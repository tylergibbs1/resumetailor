// Resume Configuration
#set page(
  paper: "us-letter",
  margin: (
    top: 1.0cm,
    bottom: 1.0cm,
    left: 1.5cm,
    right: 1.5cm,
  ),
  // In the bottom margin, so body text can never run into it
  footer: align(right, text(size: 8pt, fill: gray, style: "italic")[Last updated: Nov 2026]),
)

#set text(
  font: "Libertinus Serif",
  size: 9pt,
)

#set par(
  justify: false,
  leading: 0.48em,
)

// Section styling
#show heading.where(level: 1): it => [
  #set text(size: 11pt, weight: "bold")
  #block(
    width: 100%,
    below: 0.08cm,
    above: 0.20cm,
  )[
    #it.body
    #v(-0.3em)
    #line(length: 100%, stroke: 1pt)
  ]
]

// Helper function for two-column entries
#let twocol(date, content) = {
  block(
    width: 100%,
    breakable: false,
  )[
    #grid(
      columns: (75%, 20%),
      gutter: 5%,
      [#content],
      align(right)[#text(fill: gray)[#date]]
    )
  ]
}

// Header
#align(center)[
  #text(size: 22pt, weight: "bold")[Tyler Gibbs]
  #v(-6pt)
  #text(size: 10pt)[Lead AI Engineer]
  #v(0pt)

  #text(size: 9pt)[
    Blanchard, OK | Willing to relocate anywhere in Texas \
    #link("mailto:tylergibbs048@gmail.com")[tylergibbs048\@gmail.com] |
    #link("tel:405-320-8212")[405-320-8212] |
    #link("https://tylergibbs.dev")[tylergibbs.dev] |
    #link("https://linkedin.com/in/tylergibbss")[linkedin.com/in/tylergibbss] |
    #link("https://github.com/tylergibbs1")[github.com/tylergibbs1] |
    #link("https://x.com/tylergibbs")[x.com/tylergibbs]
  ]
]

= Summary

Mission-driven AI engineer and founder, focused on bringing critical industries to the speed of software. At Grayhaven Industries, an AI deployment company, lead a team of *4* and run sales, delivery, and engineering for healthcare and banking clients. At LexisNexis, lead technical direction for *20+* production AI workflows in legal research.

= Experience

#twocol([Aug 2026 – Present], [
  *Founder*, Grayhaven Industries
])

#block(inset: (left: 0.5cm))[
  - Lead a team of *4* and own the full cycle: sell and scope engagements, write proposals and RFP responses, set the architecture, write much of the code, and operate the systems in production.
  - Delivered custom models and agents for #text(fill: blue)[#link("https://www.grayhavenindustries.com/work")[health systems and a bank]]: a classifier that triaged *\~3 TB* of patient records at *\~93%* agreement with clinicians, a prior-authorization agent with staff review, and a fine-tuned language model that classifies fraud and abuse.
  - Built a working internet-billing platform for the Choctaw Nation of Oklahoma Housing Authority (HACNO) ConnectHome RFP: split resident/program billing, sub-ledgers, statements, online payments, and reports, sized for its *1,903* accounts across *103* locations (PostgreSQL row-level security, AWS Cognito and SES, Terraform).
  - Built *Grassfire*, a Spot EC2 runner fleet that ran real CI workloads *2.3x* faster and *7.6x* cheaper than GitHub's default runners.
]

#twocol([Aug 2023 – Present], [
  *Lead AI Engineer*, LexisNexis
])

#block(inset: (left: 0.5cm))[
  - Lead technical direction for *20+* production AI workflows in enterprise legal research, and architect the shared LLM infrastructure they run on: retrieval, prompt/version management, and model routing.
  - Built *Praetor*, an ML classifier for bankruptcy docket events and categories that improved accuracy over the legacy SVM by *9.5 points* for events and *7.7 points* for categories, saving *\~50 hrs* and *\~\$25K* net per week.
  - Own end-to-end design and delivery of the team's agentic systems, including *Gavl*, an AI browser agent that navigates court portals to extract and structure case data (Next.js on AWS: DynamoDB, S3, SQS, ECS Fargate, Terraform), and *Meridian*, an LLM provider-directory scraper that generates and caches its own scrapers across *400+* healthcare sources.
]

#twocol([2025 – Jun 2026], [
  *Founder*, Backwork
])

#block(inset: (left: 0.5cm))[
  - Built #text(fill: blue)[#link("https://backworkhealth.com")[Backwork]], a coverage-intelligence platform that searches Medicare, Medicaid, and commercial payer policies in plain English. It now covers *33,000+* active policies from *70+* payers.
  - Developed claim validation for CPT, HCPCS, and ICD-10 codes that flags prior auth requirements, missing documentation, and denial risks before submission, and policy monitoring that surfaces coverage criteria changes.
  - Built the public API with SDKs in TypeScript, Python, Ruby, and .NET, plus a Go CLI and an MCP server for AI agents. Led a *team of 3*.
]

#twocol([Jul 2021 – Aug 2023], [
  *AI Engineer (Freelance)*
])

#block(inset: (left: 0.5cm))[
  - Automated ETL pipelines end-to-end (web scraping to finished product) for Fortune 500 clients, achieving *\~90%* automation and protecting *\$2.2M* in revenue.
]

= Selected Projects

#block(inset: (left: 0.5cm))[
  - *#text(fill: blue)[#link("https://tylergibbs.dev/projects/darpa-d2-qualifier")[DARPA D2 Qualifier]]:* From one photo of a casualty, labels each limb as no injury, wound, amputation, or not testable, offline on one GPU (frozen DINOv2-L, limb localizer, RF-DETR wound detector). Scored *85.9%* on *212* never-seen photos against a *78%* target, after *118* logged experiments took cross-validated accuracy from *71.3%* to *85.8%*.
  - *Dialect:* Lets AI agents read the physical world through cameras: an agent proposes typed fields from regions of the frame, a person confirms them, and a Raspberry Pi gateway keeps them current over REST and MCP (FastAPI, PostgreSQL, AWS ECS/RDS, Terraform).
  - *#text(fill: blue)[#link("https://youtu.be/q240DAB6ssE")[Project Foresight]]:* A JEPA-style world model for an SO-101 robot arm. It predicts future camera embeddings from the arm's commanded actions and flags unexpected physical events live, such as a hand entering the workspace, with *\~0.1 s* response.
]

= Technical Skills

*Languages:* TypeScript, Python, Go, Rust, SQL \
*Backend/Infra:* Node.js, FastAPI, PostgreSQL, RabbitMQ, Docker, AWS (ECS Fargate, EC2, RDS, EKS, DynamoDB, S3, SQS), Terraform, Vercel \
*AI/ML:* LLM agents, retrieval, tool calling, evals, Model Context Protocol (MCP), PyTorch, model fine-tuning, computer vision, world models, Vercel AI SDK, Claude Agent SDK, OpenAI Agents SDK \
*Web/Product:* Next.js, TanStack Start, React, Effect, Drizzle ORM, Supabase, Playwright, browser automation, API design

= Education

#twocol([], [
  *Oklahoma State University*, BS in Computer Science (GPA: *3.9/4.0*) \
  *University of Oklahoma* | AI/ML Software Lead, Sooner Competitive Robotics (transferred to OSU)
])

// Fail the build if the resume spills onto a second page
#context assert(
  counter(page).final().first() == 1,
  message: "resume must fit on one page",
)
