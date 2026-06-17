// Sample resume in the template format this skill preserves.
// Fictional person — copy this to your project root (e.g. resume.typ) and edit.
#set page(
  paper: "us-letter",
  margin: (
    top: 1.2cm,
    bottom: 1.2cm,
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
  leading: 0.52em,
)

// Section styling
#show heading.where(level: 1): it => [
  #set text(size: 11pt, weight: "bold")
  #block(
    width: 100%,
    below: 0.12cm,
    above: 0.22cm,
  )[
    #it.body
    #v(-0.3em)
    #line(length: 100%, stroke: 1pt)
  ]
]

// Helper function for two-column entries (content left, date right)
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
  #text(size: 22pt, weight: "bold")[Jordan Rivers]
  #v(-4pt)
  #text(size: 10pt)[Software Engineer]
  #v(4pt)

  #text(size: 9pt)[
    Austin, TX |
    #link("mailto:jordan.rivers@example.com")[jordan.rivers\@example.com] |
    #link("tel:555-555-0142")[555-555-0142] |
    #link("https://example.com")[jordanrivers.dev] |
    #link("https://linkedin.com/in/example")[linkedin.com/in/jordanrivers] |
    #link("https://github.com/example")[github.com/jordanrivers]
  ]
]

= Summary

Backend software engineer with 6 years building reliable, high-throughput web services. Focused on API design, distributed systems, and developer tooling that ships and scales.

= Experience

#twocol([Jan 2022 – Present], [
  *Senior Software Engineer*, Northwind Labs
])

#block(inset: (left: 0.5cm))[
  - Designed and shipped a *REST/gRPC* API platform serving *2B+* requests/day across *40+* services.
  - Cut p99 latency *38%* by introducing read-through caching and connection pooling.
  - Mentored *4* engineers and led the team's migration to *CI/CD* with automated canary rollouts.
]

#twocol([Jun 2019 – Jan 2022], [
  *Software Engineer*, Cedar Systems
])

#block(inset: (left: 0.5cm))[
  - Built event-driven ingestion pipelines (*Kafka*, *PostgreSQL*) processing *5TB/day*.
  - Owned the on-call rotation tooling and reduced mean time to recovery by *30%*.
]

= Projects

#twocol([], [
  *Open-source CLI toolkit*
])

#block(inset: (left: 0.5cm))[
  - Authored a widely used command-line tool (*3k+* GitHub stars) for local API mocking and contract testing.
]

= Technical Skills

*Languages:* Go, Python, TypeScript, SQL \
*Backend/Infra:* PostgreSQL, Kafka, Redis, Docker, Kubernetes, AWS, Terraform \
*Practices:* API design, distributed systems, CI/CD, observability, testing

= Education

#twocol([], [
  *University of Texas at Austin*, BS in Computer Science
])
