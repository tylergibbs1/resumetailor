// Resume Configuration
#set page(
  paper: "us-letter",
  margin: (
    top: 1.0cm,
    bottom: 1.0cm,
    left: 1.5cm,
    right: 1.5cm,
  ),
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
  #text(size: 10pt)[Lead Software Engineer, Applied AI]
  #v(0pt)
  
  #text(size: 9pt)[
    Blanchard, OK | Willing to relocate anywhere in Texas \
    #link("mailto:tylergibbs048@gmail.com")[tylergibbs048\@gmail.com] |
    #link("tel:405-320-8212")[405-320-8212] |
    #link("https://tylergibbs.dev")[tylergibbs.dev] |
    #link("https://linkedin.com/in/tylergibbss")[linkedin.com/in/tylergibbss] |
    #link("https://github.com/tylergibbs1")[github.com/tylergibbs1]
  ]
]

= Summary

Lead software engineer specializing in applied AI who has shipped *20+* production systems across legal research and healthcare. Build full-stack products, shared LLM infrastructure, and autonomous browser/data agents end to end; also develop production ML systems and open-source developer infrastructure.

= Experience

#twocol([Aug 2023 – Present], [
  *Lead Software Engineer, Applied AI*, LexisNexis
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
  - Built #text(fill: blue)[#link("https://www.backworkai.com/")[Verity]], a healthcare coverage-intelligence platform that searches Medicare, Medicaid, and commercial payer policies in plain English.
  - Developed claim validation for CPT, HCPCS, and ICD-10 codes, flagging prior auth requirements, missing documentation, policy conflicts, and denial risks before submission.
  - Built policy monitoring that detects coverage criteria changes across payer policies and surfaces updates to healthcare teams.
  - Led *team of 3*: product, data ingestion, LLM workflows, and API development.
]

#twocol([Jul 2021 – Aug 2023], [
  *AI Engineer (Freelance)*
])

#block(inset: (left: 0.5cm))[
  - Automated ETL pipelines end-to-end (web scraping to finished product) for Fortune 500 clients, achieving *\~90%* automation and protecting *\$2.2M* in revenue.
  - Built agentic workflows combining web scraping and agent-driven browser automation to navigate, extract, and structure data from complex sites.
]

= Selected Projects

#twocol([], [
  *#text(fill: blue)[#link("https://tokenbasehq.com")[Tokenbase]]*
])

#block(inset: (left: 0.5cm))[
  - Built a full-stack analytics platform that shows engineering teams how their AI coding agents are used and what they cost. Shipped a signed, self-updating collector for *8 tools* and a multi-tenant TanStack/PostgreSQL dashboard with device authentication and privacy controls.
]

#twocol([], [
  *#text(fill: blue)[#link("https://surgeforecast.com")[Surge]]*
])

#block(inset: (left: 0.5cm))[
  - Built an open-source day-ahead demand forecasting platform for the U.S. power grid. After fine-tuning Chronos-2 on seven years of data from *53 balancing authorities*, it beat grid operators' forecasts in *6 of 7 major regions* with *\~40% lower average error*. Released it as a Python library, FastAPI service, and live web app.
]

#twocol([], [
  *Developer & Agent Infrastructure*
])

#block(inset: (left: 0.5cm))[
  - Built #text(fill: blue)[#link("https://github.com/tylergibbs1/nerve")[Nerve]], a TypeScript compiler that validates electrical-harness designs with *43 deterministic checks* and generates wiring diagrams, bills of materials, test plans, and manufacturing packets.
  - Also built #text(fill: blue)[#link("https://github.com/tylergibbs1/toolmux")[toolmux]], an MCP proxy that cuts agent tool-schema context up to *96%*, and #text(fill: blue)[#link("https://github.com/tylergibbs1/sandcastle")[Sandcastle]], a sandbox for untrusted JavaScript benchmarked at *380K ops/sec*.
]

= Public Technical Work

Publish applied AI research and demos through #text(fill: blue)[#link("https://www.youtube.com/@AppliedTensors")[Applied Tensors]] and #text(fill: blue)[#link("https://tylergibbs.dev/blog/training-in-orbit")[tylergibbs.dev]], including a *45-experiment* study of fault-aware model training that preserved stable validation quality under simulated radiation up to *10,000x LEO*.

= Technical Skills

*Languages:* TypeScript, Python, Rust, SQL \
*Backend/Infra:* Node.js, FastAPI, PostgreSQL, RabbitMQ, Docker, AWS (ECS Fargate, EKS, DynamoDB, S3, SQS), Terraform, Vercel \
*AI/ML:* LLM agents, retrieval, tool calling, evals, Model Context Protocol (MCP), PyTorch, model fine-tuning, time-series forecasting, Vercel AI SDK, Claude Agent SDK, OpenAI Agents SDK \
*Web/Product:* Next.js, TanStack Start, React, Drizzle ORM, Supabase, Playwright, browser automation, API design

= Education

#twocol([], [
  *Oklahoma State University*, BS in Computer Science (GPA: *3.9/4.0*) \
  *University of Oklahoma* | Robotics Team (before transferring to OSU)
])

#place(
  bottom + right,
  text(size: 8pt, fill: gray, style: "italic")[Last updated: Jul 2026]
)
