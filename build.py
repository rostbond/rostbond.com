import json
import shutil
import os
from jinja2 import Template

with open('resume.json', 'r', encoding='utf-8') as f:
    resume_data = json.load(f)

with open('index.html.j2', 'r', encoding='utf-8') as f:
    template_content = f.read()

template = Template(template_content)
json_str = json.dumps(resume_data, ensure_ascii=False, indent=2)

rendered_html = template.render(resume_json=json_str)

os.makedirs('dist', exist_ok=True)
with open('dist/index.html', 'w', encoding='utf-8') as f:
    f.write(rendered_html)