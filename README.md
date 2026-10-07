# 🪹 NEST - Next Generation Estate Technology

A cross-platform mobile marketplace application built with **Flutter (Dart)** and an **Interactive Web Application (React + Vite + Tailwind CSS)**.

**NEST** connects **Owners**, **Builders**, and **Buyers** under a single account system with dynamic role-switching, AI valuation engines, Ask AI comparative reasoning, Uber-style telephony call masking, watermarked legal document security, and real-time builder analytics.

---

## 🌟 Key Features

### 1. 🔄 Unified Account & Dynamic Role Switching
- **Single Sign-On**: Users sign up once and seamlessly toggle between **Buyer ⇄ Owner ⇄ Builder** roles from their profile.
- **Context-Aware Dashboard**: Role switching dynamically updates available screens, onboarding wizards, analytics, and privacy actions without re-authenticating.

### 2. 📝 Structured Multi-Role Onboarding Flows
- **Owner Onboarding (8 Steps)**:
  1. Contact Details
  2. Duration of Ownership
  3. Selling Price & Terms
  4. Photo/Video Media Uploader
  5. Building Age & Location
  6. Surrounding Area & Connectivity Details
  7. Legal Document Vault Upload
  8. Review & Publish Listing
- **Builder Onboarding (8 Steps)**:
  1. Developer Company Details
  2. Project Schemes Offered
  3. Unit Configurations Matrix (`1BHK`, `2BHK`, `3BHK` with sqft and pricing)
  4. Masterplan Location
  5. RERA & Business Registration
  6. Renders & 3D Walkthrough Gallery
  7. Infrastructure & Connectivity Highlights
  8. Review & Publish Project Scheme
- **Buyer Onboarding (5 Steps)**:
  1. Profile Basics
  2. Budget Range Selector
  3. Location/City Filter
  4. Preferred BHK Configuration
  5. Personalized Feed Initialization

### 3. 🤖 NEST AI Engine Layer
- **AI Natural Language & Voice Search**: Semantic search bar parsing queries like *"3BHK under 1.5 Cr in Whitefield near top schools"* with voice input support.
- **AI Property Valuation & 5-Year Growth Forecast**: Fair market value estimator and 5-year capital appreciation projection curve powered by local infrastructure signals.
- **Ask NEST AI Property Comparison**: Side-by-side comparative analysis of live listings calculating a **Unified Property Suitability Score (0-100%)**, *"Why Choose / Why Not"* reasoning, and environmental & geological risk profiles (seismic zone, flood risk, AQI, groundwater table).
- **Persistent NEST AI Assistant**: Floating chat widget providing context-specific answers on maintenance costs, Vastu compliance, and renovation ideas.

### 4. 🛡️ Privacy, Safety & Telephony Call Masking
- **Uber-Style Call Masking**: Generates temporary virtual proxy numbers (e.g. `+1 (888) 555-XXXX`) for buyer-seller contacts with 30-minute expiring sessions to keep real phone numbers private.
- **Encrypted Legal Document Protection**: Uploaded title deeds, RERA registrations, and tax receipts are protected by **dynamic watermarking canvas previewers** (`CONFIDENTIAL • NEST VERIFIED PREVIEW`), disabling direct downloading, and logging audit access trails.

### 5. ⚡ Flash Ads & Builder Analytics
- **Flash Ads Carousel**: Rotating sponsored builder project banners featuring custom countdown timers and discount badges (*"5% Early Bird Discount before Nov 30"*).
- **Builder Engagement Dashboard**: Aggregated anonymized view counts, buyer intent reactions, call requests, and bookmark metrics.

---

## 🏗️ Tech Stack

- **Mobile Framework**: Flutter (Dart) — Cross-platform Android + iOS from one codebase
- **Web App**: React 19, Vite, Tailwind CSS v4, Lucide Icons, Recharts
- **State Management**: Provider (Flutter) / React Context
- **Design System**: Dark Mode, Glassmorphism, Responsive Mobile Frame

---

## 🚀 Running the Project

```bash
# 1. Install dependencies
npm install

# 2. Run local development server
npm run dev
```

---

## 📜 License
Licensed under the MIT License.
