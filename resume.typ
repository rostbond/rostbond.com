#import "@preview/simple-technical-resume:0.1.1": *

#let data = json("resume.json")

// YYYY-MM-DD => MMM YYYY
#let parse-date(date) = {
  if date == none or date == "Present" or date == "" { return "Present" }
  
  let parts = date.split("-")
  
  if parts.len() < 2 { return date } 
  
  datetime(
    year: int(parts.at(0)),
    month: int(parts.at(1)),
    day: if parts.len() > 2 { int(parts.at(2)) } else { 1 }
  ).display("[month repr:short] [year]")
}

#set page(paper: "us-letter", margin: (x: 1.27cm, y: 1.27cm))
#set list(indent: 0.4em)

#show: resume.with(
  font: "Helvetica Neue",
  font-size: 11pt,
  personal-info-font-size: 9pt,
  personal-info-position: center,
  author-name: data.basics.name,
  author-position: center,
  location: data.basics.location.city + ", " + data.basics.location.countryCode,
  phone: data.basics.phone,
  email: data.basics.email,
  website: data.basics.website,
  linkedin-user-id: data.basics.profiles.at(0).username,
  github-username: data.basics.profiles.at(0).username,
)

#align(center)[
  #text(size: 11pt, weight: "semibold")[#data.basics.label]
]

#custom-title("Summary", spacing-between: 0.8em)[
  #data.basics.summary.join([#v(0.4em)])
]

#custom-title("Experience", spacing-between: 0.8em)[
  #for job in data.work [
    #let start = parse-date(job.startDate)
    #let end = parse-date(job.at("endDate", default: "Present"))
    
    *#job.position* | #start - #end \
    #job.name #text(style: "italic")[#job.at("location", default: "")]
    
    #for highlight in job.highlights [
      - #highlight
    ]
    #v(0.4em)
  ]
]

#custom-title("Skills", spacing-between: 0.8em)[
    #for skill in data.skills [
      *#skill.name*: #skill.keywords.join(", ") \
    ]
]

#custom-title("Projects", spacing-between: 0.8em)[
  #for project in data.projects [
    #project-heading(project.name, project-url: project.url,)[
      #for highlight in project.highlights [
        - #highlight
      ]
    ]
  ]
]

#custom-title("Education", spacing-between: 0.8em)[
  #for edu in data.education [
    #let start = parse-date(edu.startDate)
    #let end = parse-date(edu.at("endDate", default: none))
    #let date-range = if end != none [#start - #end] else [#start]
    
    *#edu.institution* | #date-range \
    #edu.studyType in #edu.area
  ]
]

#custom-title("Certifications", spacing-between: 0.8em)[
  #for certificate in data.certificates [
    *#certificate.name* | #parse-date(certificate.date) \
  ]
]

#custom-title("Languages", spacing-between: 0.8em)[
  #for language in data.languages [
    *#language.language*: #language.fluency \
  ]
]