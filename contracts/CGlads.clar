;; CryptoGladiators
;; A blockchain-based character collection and battle system
;; Where players can mint, trade, and battle with unique characters

;; Error codes
(define-constant ERR_NOT_FOUND (err u404))
(define-constant ERR_UNAUTHORIZED (err u401))
(define-constant ERR_TRANSFER_FAILED (err u402))
(define-constant ERR_COOLDOWN (err u403))
(define-constant ERR_INVALID_INPUT (err u400))

;; Define constants for game parameters
(define-constant CONTRACT_OWNER tx-sender)
(define-constant MINT_PRICE u100000) ;; in microSTX
(define-constant MAX_LEVEL u100)
(define-constant BASE_XP_REQUIRED u100)
(define-constant MIN_PRICE u1000) ;; Minimum listing price
(define-constant MAX_CHARACTERS_PER_USER u100) ;; Maximum characters per user

;; Define custom types for our characters
(define-data-var last-character-id uint u0)

(define-map characters
    uint
    {
        owner: principal,
        name: (string-ascii 24),
        level: uint,
        xp: uint,
        attack: uint,
        defense: uint,
        last-battle-block: uint
    }
)

;; Keep track of ownership counts
(define-map user-character-count principal uint)

;; Market listings
(define-map market
    uint  ;; character ID
    {
        price: uint,
        seller: principal
    }
)

;; Read-only functions
(define-read-only (get-character (character-id uint))
    (map-get? characters character-id)
)

(define-read-only (get-listing (character-id uint))
    (map-get? market character-id)
)

(define-read-only (get-owner-count (user principal))
    (default-to u0 (map-get? user-character-count user))
)
