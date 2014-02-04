(require 'org)
(require 'ox-rss)

(defvar nico-website-html-head
  "<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='css/site.css' type='text/css'/>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<link href='http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css' rel='stylesheet'>")

(defvar nico-analytics-html
  "<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-2614862-2', 'nicolas-petton.fr');
  ga('send', 'pageview');
</script>")

(defvar nico-website-html-blog-head
  "<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='../css/site.css' type='text/css'/>
<link rel='stylesheet' href='../css/blog.css' type='text/css'/>
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
Copyright 2014 %a (%v HTML).<br>
Last updated %C. <br>
Built with %c.
</div>")

(defun nico-html-head ()
  (concat nico-website-html-head nico-analytics-html))
(defun nico-blog-html-head ()
  (concat nico-website-html-blog-head nico-analytics-html))

(setq org-publish-project-alist
      `(("org"
		 :base-directory "~/work/nicolas-petton.fr/"
		 :base-extension "org"
		 :publishing-directory "~/Public/nicolas-petton.fr/"
		 :publishing-function org-html-publish-to-html
		 :section-numbers nil
		 :with-toc nil
		 :html-head ,(nico-html-head)
		 :html-preamble ,nico-website-html-preamble
		 :html-postamble ,nico-website-html-postamble)

		("blog"
		 :base-directory "~/work/nicolas-petton.fr/blog"
		 :base-extension "org"
		 :publishing-directory "~/Public/nicolas-petton.fr/blog/"
		 :publishing-function org-html-publish-to-html
		 :section-numbers nil
		 :with-toc nil
		 :html-head ,(nico-blog-html-head)
		 :html-head-extra
         "<link rel=\"alternate\" type=\"application/rss+xml\"
                href=\"http://nicolas-petton.fr/blog/index.xml\"
                title=\"RSS feed\">"
		 :html-preamble ,nico-website-html-preamble
		 :html-postamble ,nico-website-html-postamble)

		("ressources"
		 :base-directory "~/work/nicolas-petton.fr/"
		 :base-extension "jpg\\|jpeg\\|gif\\|png\\|js\\|html\\|css\\|ogv"
		 :recursive t
		 :publishing-directory "~/Public/nicolas-petton.fr/"
		 :publishing-function org-publish-attachment)

		("rss"
		 :base-directory "~/work/nicolas-petton.fr/blog/"
		 :base-extension "org"
		 :publishing-directory "~/Public/nicolas-petton.fr/blog/"
		 :publishing-function (org-rss-publish-to-rss)
		 :section-numbers nil
		 :table-of-contents nil
		 :html-link-home "http://nicolas-petton.fr/blog/"
		 :rss-image-url "http://nicolas-petton.fr/images/nicolas-petton.png"
		 :html-link-use-abs-url t)

		("website" :components ("org" "blog" "rss" "ressource"))))

(provide 'nico-org-publish)
