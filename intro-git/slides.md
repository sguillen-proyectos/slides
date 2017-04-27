

# ![](logo.png)
# A brief Git Introduction - XTime
###### Sergio Guillen Mantilla


---
### Antes que nada, funciona en cualquier sistema operativo
OSX
GNU/Linux
Windows con git-bash
Y una gran cantidad de GUI + la integración con IDE

---

# Snapshots

---
# Basic Commit Structure

---
# Commit messages

---
# Time Travel :watch:

---
# Branches

---
# Branches

---
# Remotes
Un remote es simplemente otro repositorio git que puede ser accedido remotamente:
* GitHub
* GitLab
* Bitbucket
* Gogs
* git init --bare *(servidor propio)*

---
# Remotes
Los comando básicos para trabajar con remotes son:
```
$ git pull <remote> <branch>
$ git push <remote> <branch>
```

---
# GitHub
GitHub cuenta con un feature super importante que son los Pull Requests, que básicamente nos sirve como mecanismo de contribución y tener un mejor control de lo que se acepta en un branch.

```
From branch ENG-1234 to development
From development to Testing
...
```
---
# Others
* Squash
* Stash
* Cherry-pick
---
# Resources
* ProGit - Scott Chacon & Ben Straub
* Git con Tom&Jerry - try.github.io
* Git Branching - learngitbranching.js.org


<!--
things to do:
-- for any operating system --

let's you tell the story of your project
    snapshots which is a commit
        say structure of commit (hash, message, etc.)
commit messages
time travel or checkout :DD
branches (para hacer atrocidades) lo cual genera mucho flujos de trabajo
three-way-merge

branch pointer to a commit to follow branch
merge a combination of two or more branches 

a remote
clone 
push
pull

other tips
   stash
   squash
github
   pull requests
   
migration from svn
challenges

resources
   progit
   git with tom and jerry
   git branching
->