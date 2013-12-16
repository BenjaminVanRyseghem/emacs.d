(require 'org)
(require 'ox-rss)

(defvar nico-website-html-head
"<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='css/site.css' type='text/css'/>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<link href='http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css' rel='stylesheet'>")

(defvar nico-website-html-blog-head
"<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='../css/site.css' type='text/css'/>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<link href='http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css' rel='stylesheet'>")

(defvar nico-website-html-preamble 
  "<div class='nav'>
<ul>
<li><a href='/'>Home</a></li>
<li><a href='/blog/index.html'>Blog</a></li>
<li><a href='http://github.com/NicolasPetton'>GitHub</a></li>
<li><a href='http://twitter.com/NicolasPetton'>Twitter</a></li>
<li><a href='/contact.html'>Contact</a></li>
</ul>
</div>")

(defvar nico-website-html-postamble 
  "<div class='footer'>
Copyright 2013 %a (%v HTML).<br>
Last updated %C. <br>
Built with %c.
</div>")


(setq org-publish-project-alist
      `(("org"
	 :base-directory "~/work/nicolas-petton.fr/"
	 :base-extension "org"
	 :publishing-directory "~/Public/nicolas-petton.fr/"
	 :publishing-function org-html-publish-to-html
	 :section-numbers nil
	 :with-toc nil
	 :html-head ,nico-website-html-head
	 :html-preamble ,nico-website-html-preamble
	 :html-postamble ,nico-website-html-postamble)

	("blog"
	 :base-directory "~/work/nicolas-petton.fr/blog"
	 :base-extension "org"
	 :publishing-directory "~/Public/nicolas-petton.fr/blog/"
	 :publishing-function org-html-publish-to-html
	 :section-numbers nil
	 :with-toc nil
	 :html-head ,nico-website-html-blog-head
	 :html-head-extra
         "<link rel=\"alternate\" type=\"application/rss+xml\"
                href=\"http://nicolas-petton.fr/blog/index.xml\"
                title=\"RSS feed\">"
	 :html-preamble ,nico-website-html-preamble
	 :html-postamble ,nico-website-html-postamble)

	("ressources"
	 :base-directory "~/work/nicolas-petton.fr/"
	 :base-extension "jpg\\|gif\\|png\\|js\\|html\\|css"
	 :recursive t
	 :publishing-directory "~/Public/nicolas-petton.fr/"
	 :publishing-function org-publish-attachment)

	("rss"
	 :base-directory "~/work/nicolas-petton.fr/blog/"
	 :base-extension "org"
	 :publishing-directory "~/Public/nicolas-petton.fr/blog/"
	 :publishing-function (org-rss-publish-to-rss)
	 :html-link-home "http://nicolas-petton.fr/blog/"
	 :html-link-use-abs-url t)

	("website" :components ("org" "blog" "rss" "ressource"))))

(provide 'nico-org-publish)
