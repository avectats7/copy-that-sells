# Eval Prompts

Twelve prompts that cover the formats and languages the skill targets. Run any of these in a fresh Claude session with the skill installed and save the output to `outputs/<prompt-id>.md`.

---

## 01-billboard-fintech-es

> Necesito un billboard en español para Caja, una app de ahorros automáticos. La promesa central: la app guarda un porcentaje de cada compra con tarjeta sin que el usuario lo piense. Target: profesionales de 25 a 35 años en Buenos Aires. Voz seca, rioplatense. Format OOH, 3 segundos de lectura.

## 02-saas-pricing-page-en

> Write a pricing page for Ledgerline, a reconciliation tool for B2B finance teams. Three plans: Free, Growth ($49/mo), Scale ($199/mo). Buyer is a finance lead at a 50 to 500 person company. Differentiator: reconciles a month of transactions in 9 minutes vs 2 days for competitors. Voice: technical, plain, confident.

## 03-dtc-manifesto-en

> Write a launch manifesto for Llano, a DTC coffee brand sourcing from a single farm in Colombia. The category problem: specialty coffee marketing has become vague and full of tasting notes no one understands. Voice: founder, plain, takes a stance. Length 200 to 400 words. Format: homepage manifesto.

## 04-founder-cold-email-en

> Cold email from a founder to engineering leads at series A/B startups. Product is Pulse, an async standup tool that writes the standup from GitHub PRs and Slack activity. $12/user/month. Reference customers: Linear, Vercel, Render, Modal. Voice: founder, plain, direct. CTA: 15 minute call. 75 to 130 words.

## 05-app-store-listing-en

> App Store listing for Aside, a US savings app that rounds up card purchases and saves the change at 4.5% APY. Target: 22 to 30 year olds in the US with $0 to $3,000 in savings. Need: app name, subtitle, promotional text, first 3 lines of description, full description, 5 screenshot captions. Voice: confident, light, plain.

## 06-paid-social-meta-en

> Write a paid Meta ad for Pulse, the async standup tool from prompt 04. Targeting VP Engineering at 50 to 200 person companies. Need: primary text (40 to 90 words), headline (5 to 10 words), description (20 to 30 words). The ad will run with a 15 second product walkthrough video.

## 07-paid-search-en

> Write a Google responsive search ad for Ledgerline (the reconciliation tool from prompt 02). Search query the ad is targeting: "reconciliation software for startups." Format: 10 headlines of up to 30 characters each covering query echo, differentiator, proof, risk reversal, and CTA; 4 descriptions of up to 90 characters each. Note which headline, if any, you would pin and why. Voice: technical.

## 08-newsletter-subject-line-en

> Write 5 subject line candidates for a weekly newsletter to founders, edition topic: "what 32 cold emails this week taught me." The newsletter open rate has been falling and we are trying to push it back up. Audience is sophisticated and will recognise gimmicks.

## 09-diagnostic-rewrite-en

> Here is our current homepage hero. It is not converting. Make it stronger:
>
> "Welcome to our innovative platform that empowers teams to unlock their full potential through seamless collaboration and cutting-edge AI capabilities. Get started today and transform the way you work."

## 10-paid-social-instagram-es

> Anuncio en Instagram para Caja, app de ahorros automáticos (ver brief 01). Formato: primary text 40 a 90 palabras, headline 5 a 10. Voz rioplatense seca. Target: mismo que el billboard.

## 11-public-service-grave-en

> Write OOH copy for a public health campaign about screen time in teenagers. Sponsor is the UK Department of Health. Voice: public service grave, no preaching. Length: a single line plus optional 6 to 12 word sub. No exaggeration; the audience has heard the alarmist version and tuned it out.

## 12-long-copy-sales-page-en

> Write the hero section and the first three sections (problem, why current solutions fail, introduce the offer) of a long-copy sales page for a $1,200 online course teaching founders how to write their own cold email. Voice: founder narrator. Length per section: 100 to 300 words. The buyer has tried 2 to 3 cold email templates from popular newsletters and gotten nothing.

---

## How to use this file

Pick a prompt. Paste into a fresh session with the skill installed. Save the model's complete output (Idea, Final copy, Alternates, Notes) to `evals/outputs/<prompt-id>.md`. Run `./evals/check_banned_words.sh evals/outputs/<prompt-id>.md`. Score against `rubric.md`.
