# trusha-job-search

Daily job search digest for Trusha Tiwari — FP&A / Financial Analyst / Strategy / Consulting roles in NYC/Remote.

## Stack
Python 3.9+, GitHub Actions, Adzuna API, The Muse API, Groq Llama 3.3 70B, Anthropic Claude, Gmail SMTP

## Current State (2026-03-17)
- Production — running daily via GitHub Actions cron at 8am ET
- Sends email digest with 20 ranked jobs, AI scoring, resume gap analysis, tailored resumes
- Has CLAUDE.md and .claude/ docs
- Stable after recent bug fix round

## Recent Activity
- Fixed UnboundLocalError for tf in _build_html when no tailored resume
- Always-send digest: auto-widen window, expire seen jobs, quiet-day email
- Trimmed Adzuna queries 13→8 to stay under free tier (250 calls/mo)

## Known Issues
- Modified send_email.py and seen_jobs.json uncommitted locally
- Untracked resumes/tailored/ directory

## Next Steps
- Commit uncommitted local changes
- Monitor daily runs for stability
