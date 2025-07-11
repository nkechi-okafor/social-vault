;; SocialVault - Next-Generation Creator Economy Protocol
;;
;; Title: SocialVault - Decentralized Creator Economy & Community Governance
;;
;; Summary:
;; A comprehensive Bitcoin-secured smart contract ecosystem that transforms how 
;; creators monetize their content and build communities through tokenized 
;; engagement, dynamic reputation systems, and NFT-powered membership tiers.
;;
;; Description:
;; SocialVault revolutionizes the creator economy by establishing a trustless, 
;; Bitcoin-backed infrastructure on Stacks L2 that enables creators to build 
;; sustainable income streams through community engagement. The protocol 
;; combines algorithmic reputation scoring with NFT-based membership systems,
;; creating a self-sustaining ecosystem where creators are rewarded for quality
;; content and community building.
;;
;; Core Innovation:
;; - Time-decay reputation algorithms that reward consistent engagement
;; - Multi-tier NFT membership system with progressive benefits
;; - Microtransaction-based creator monetization with built-in incentives
;; - Community governance through tokenized reputation certificates
;; - Creator-configurable earning parameters and reward distribution
;; - Emergency controls with treasury management capabilities
;;
;; Built on Stacks with Clarity, inheriting Bitcoin's security and finality
;; while enabling programmable social and economic interactions.

;; ERROR CONSTANTS

(define-constant ERR-UNAUTHORIZED (err u100))
(define-constant ERR-ALREADY-EXISTS (err u101))
(define-constant ERR-NOT-FOUND (err u102))
(define-constant ERR-INSUFFICIENT-BALANCE (err u103))
(define-constant ERR-INVALID-AMOUNT (err u104))
(define-constant ERR-INVALID-THRESHOLD (err u105))
(define-constant ERR-INVALID-TIER (err u106))
(define-constant ERR-COOLDOWN-ACTIVE (err u107))
(define-constant ERR-EXPIRED-REPUTATION (err u108))

;; CONTRACT CONFIGURATION

(define-constant CONTRACT-OWNER tx-sender)
(define-constant REPUTATION-DECAY-PERIOD u144) ;; ~24 hours in blocks
(define-constant ENGAGEMENT-COOLDOWN u6) ;; ~1 hour in blocks
(define-constant MIN-TIP-AMOUNT u1000000) ;; 1 STX in microSTX
(define-constant MAX-REPUTATION-SCORE u10000)

;; STATE VARIABLES

(define-data-var contract-paused bool false)
(define-data-var total-reputation-nfts uint u0)
(define-data-var total-membership-nfts uint u0)
(define-data-var treasury-balance uint u0)

;; NFT DEFINITIONS

(define-non-fungible-token reputation-nft uint)
(define-non-fungible-token membership-nft uint)

;; DATA STRUCTURES

(define-map user-profiles 
  principal 
  {
    reputation-score: uint,
    last-activity-block: uint,
    total-earnings: uint,
    engagement-count: uint,
    reputation-nft-id: (optional uint),
    membership-nft-id: (optional uint)
  }
)

(define-map creator-settings
  principal
  {
    earnings-threshold: uint,
    reward-per-engagement: uint,
    is-active: bool,
    total-distributed: uint
  }
)

(define-map engagement-history
  {user: principal, target: principal, stacks-block-height: uint}
  {
    engagement-type: (string-ascii 20),
    amount: uint,
    processed: bool
  }
)

(define-map membership-tiers
  uint
  {
    tier-name: (string-ascii 50),
    min-reputation: uint,
    benefits: (string-ascii 200),
    access-level: uint
  }
)

(define-map reputation-nft-metadata
  uint
  {
    owner: principal,
    reputation-score: uint,
    minted-at: uint,
    last-updated: uint
  }
)

(define-map membership-nft-metadata
  uint
  {
    owner: principal,
    tier-level: uint,
    granted-at: uint,
    expires-at: (optional uint)
  }
)

;; UTILITY FUNCTIONS

(define-private (min-uint (a uint) (b uint))
  (if (< a b) a b)
)

(define-private (max-uint (a uint) (b uint))
  (if (> a b) a b)
)

;; READ-ONLY FUNCTIONS

(define-read-only (get-user-profile (user principal))
  (map-get? user-profiles user)
)

(define-read-only (get-creator-settings (creator principal))
  (map-get? creator-settings creator)
)

(define-read-only (get-current-reputation (user principal))
  (let (
    (profile (unwrap! (map-get? user-profiles user) (err u0)))
    (last-activity (get last-activity-block profile))
    (current-block stacks-block-height)
    (blocks-since-activity (- current-block last-activity))
    (base-reputation (get reputation-score profile))
  )
    (if (> blocks-since-activity REPUTATION-DECAY-PERIOD)
      (let ((decay-factor (/ blocks-since-activity REPUTATION-DECAY-PERIOD)))
        (if (>= decay-factor base-reputation)
          (ok u0)
          (ok (- base-reputation (min-uint decay-factor base-reputation)))
        )
      )
      (ok base-reputation)
    )
  )
)

(define-read-only (get-membership-tier (tier-id uint))
  (map-get? membership-tiers tier-id)
)

(define-read-only (get-reputation-nft-info (nft-id uint))
  (map-get? reputation-nft-metadata nft-id)
)

(define-read-only (get-membership-nft-info (nft-id uint))
  (map-get? membership-nft-metadata nft-id)
)

(define-read-only (calculate-tier-for-reputation (reputation uint))
  (if (>= reputation u8000)
    u4 ;; Platinum
    (if (>= reputation u5000)
      u3 ;; Gold
      (if (>= reputation u2000)
        u2 ;; Silver
        u1 ;; Bronze
      )
    )
  )
)

(define-read-only (is-contract-paused)
  (var-get contract-paused)
)