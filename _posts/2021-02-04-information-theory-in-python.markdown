---
layout: post
title: "Teaching during Lockdown or Information Theory in Python"
date: 2021-02-04 20:00:00 +0000
categories: jekyll update
comments: true
---

It's been a long while since the last post, but also so many things have happened. We have been through a pandemic (well, we're actually still in the middle of it, but at least there seems to be some light on the horizon due to the start of vaccination). Oh, and thanks for asking, the puffins are fine. Actually even better than ever. They seem to be the only people enjoying the lockdown, what can i tell ya ... But for all normal people, including students and lecturers (and don't ya dare tell me we're not normal people now), it's been incredibly hard.

Personally, I found lecturing without being in the same room with students, quite challenging. Don't get me wrong, some things are even better this way, and I'm not talking about students not having to see me as I'm still using my camera (muahaha), but for example recorded lectures are a huge plus for students, as they can rewatch them at their leasure and take more time to take in new stuff.

So things have changed, and it mostly affects the use of technology to get the most of our lectures. I hope I will post a few things about the best way (imho) to work on maths problems collaboratively online, but I'm not quite there. Still testing stuff. However, this post is all about how to use code to make math problems more interesting. In particular, I'll be looking into teaching information theory in Python today. You can find all my code, here: [GitHub Information Theory Repo](https://github.com/bozicb/information-theory) It's still in its baby shoes and growing constantly, but feel free to fork and send me pull requests.

# Some Basics
As I mentioned the challenges lecturer face with online teaching, what I was referring to has mostly to do with student interaction. We can't see faces, so we have little information of how bored students are at any specific point during a lecture, how confused they look, or just how they react to our inputs and monologues. So what I found works at least in parts to get a feeling for the mood in my class is doing live polls on either the materials that I just covered, to see how much of a clue they got, or just general questions about how they feel and whether the pace is ok for them. I recommend doing this every 15 to 20 minutes or at any point that makes sense, but to err rather on the too frequent side. My recent lecture covered information theory, so I stopped to leave them a few minutes to work on a simple problem or ask if they understood a formula. Luckily, [Bongo](https://www.bongolearn.com) supports live polls and has easy access to them, so I can create a poll even while I talk and can get instant feedback from students.

In addition to explaining formulae on the virtual whiteboard and polling results of examples from students, I am also using Python code to explain how to implement formulae. In my case this was `entropy`, `ig` (information gain), `ig_ration`, and `gini_index`.

# The Code
The most useful effect of showing students how to turn a mathematical formula into code is that they are forced to think about how it is applied, i.e. what you need to feed it, and what it will give you back. As an example, if we look at the formula for Shannon's Entropy in Python code:

{% highlight python %}
sum([p*math.log(p,2) for p in probabilities])*(-1)
{% endhighlight %}

It becomes apparent that there needs to be a list of probabilities (according to our lecture examples it could be the probabilities to draw one of the four possible suits of cards out of a deck), and it will give us the entropy in bits. So we hope. But the of it, is that it actually doesn't look very different from the original formula in mathematical notation. The best way to check if it's not only apparent to you, is to have a random student explain it to you.

It gets a little bit harder though, if we look at the code for information gain (I've only outlined the interesting parts):

{% highlight python linenos %}
ps = []
for l in abt[target].unique():
   ps.append(abt[target].value_counts()[l]/num_rows)
e = entropy(ps)
rems = []
for feature in features:
   levels = abt[feature].unique()
   part_ents = []
   for level in levels:
      weight = abt[feature].value_counts()[level]/num_rows
      ent = entropy(abt.loc[abt[feature] == level][target].value_counts()/len(abt.loc[abt[feature] == level]))
      part_ents.append(weight*ent)
   rems.append(sum(part_ents))
infGains = e - rems
{% endhighlight %}

This looks a bit more confusing, at it will take a while for most students to understand, how we got here from the formula for the remainder of every feature. But still it follows the same process and once you understand how the code works, you will never again forget how to solve an information gain problem on paper again. OK, this is a huge exaggeration, but it definitely will be way harder compared to only solving problems on paper to get you ready for an exam :)

# Publishing on GitHub
As far as publishing is concerned, I found [GitHub](github.com) to be a good place to let students share, fork, modify and play around with the code. Sometimes, they will even do useful pull requests and make contributions to your code, so it's subject to constant improvement and reuse for future lectures.

# Other Notes on Online Teaching
So online teaching can be real fun and really depends on what you make of it. We are very lucky and priviledged to have so many options. I've even got my hands on a drawing tablet recently, so expect a blog post about that soon(ish) too. Overall, benefits are balancing out lots of the disadvantages and I will certainly keep using many online teaching elements in face to face lectures once we can return to some kind of *normal*. It's really been such a long time now, and I'm not sure if I would recognise a student if I saw them or even my own colleagues. I really miss the coffee chats and social interaction, not to talk about the occasional pints after work.

So long and thanks for all the fish, friends. Please let me know about your thoughs in the comments or, even better, let us all know about how you're doing with online teaching, if you are a student or lecturer, or otherwise how you're managing life in a pandemic. Hope you're all safe and healthy. Over to the puffins ...

![Fish?](/images/fish.png)

{% if page.comments %}
<div id="disqus_thread"></div>
<script>

/**
*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
/*
var disqus_config = function () {
this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://bozicb-github-io.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
                            
{% endif %}
