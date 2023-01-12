stage doc:
    git add docs/README.md
    git add docs/images/*.*
    git add {{doc}}* 

commit doc: (stage doc)
    git commit -m "adding {{doc}}"

push doc: (commit doc)
    git push origin master