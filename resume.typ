#import "@preview/simple-technical-resume:0.1.1": *

#let data = json("resume.json")
#let spacing = 0.1em

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
  linkedin-user-id: data.basics.profiles.at(0).username,
  github-username: data.basics.profiles.at(0).username,
  paper: "us-letter",
  top-margin: 0.75in,
  right-margin: 0.75in,
  left-margin: 0.75in,
  bottom-margin: 0.75in
)

#align(center)[
  #text(size: 11pt, weight: "semibold")[#data.basics.label]
]


#custom-title("Summary", spacing-between: spacing)[
  #data.basics.summary.join([#v(0.3em)])
]

#custom-title("Experience", spacing-between: spacing)[
  #for job in data.work [
    #block(breakable: false, width: 100%)[
      #let start = parse-date(job.startDate)
      #let end = parse-date(job.at("endDate", default: "Present"))
      
      *#job.position* | #job.name | #start - #end \
      
      #for highlight in job.highlights [
        - #highlight
      ]
    ]
    #v(0.3em)
  ]
]

#custom-title("Skills", spacing-between: spacing)[
    #for skill in data.skills [
      *#skill.name*: #skill.keywords.join(", ") \
    ]
]

#custom-title("Projects", spacing-between: spacing)[
  #for project in data.projects [
    #project-heading(project.name, project-url: project.url,)[
      #for highlight in project.highlights [
        - #highlight
      ]
    ]
  ]
]

#custom-title("Education", spacing-between: spacing)[
  #for edu in data.education [
    #let start = parse-date(edu.startDate)
    #let end = parse-date(edu.at("endDate", default: none))
    #let date-range = if end != none [#start - #end] else [#start]
    
    *#edu.institution* | #date-range \
    #edu.studyType in #edu.area
  ]
]

#custom-title("Certifications", spacing-between: spacing)[
  #for certificate in data.certificates [
    *#certificate.name* | #parse-date(certificate.date) \
  ]
]

#custom-title("Languages", spacing-between: spacing)[
  #for language in data.languages [
    *#language.language*: #language.fluency \
  ]
]
