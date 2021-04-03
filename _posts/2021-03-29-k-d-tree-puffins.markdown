---
layout: post
title: "What if k-d tree was about puffins ... ?"
date: 2021-03-29 23:40:00 +0000
categories: d3 javascript similarity visualisation
comments: true
---

Heya everyone! Hope you're doing well and staying safe by keeping your distance and wearing a mask. It's been a busy time again for the puffins. For some reason I feel like you even have more work during a lockdown, or is it just that the lack of real world social interaction automatically makes you work more? Anyways, this time the puffins would like to show you a **k-d tree** example they've been working on, so let's get straight to it ...

## Intro
First of all, let's explain a bit what this is all about. If you haven't followed the blog, this is going a bit beyond topic of *k*-NN which we were touching on [here](/ruby/similarity/knn/machine-learning/2021/03/11/explain-knn-in-ruby-code.html), so make sure you read that post if you haven't already. If you're already familiar with *k*-NN or read the last post (which I in no way consider anything near an equivalent), you should have no problem of understanding **k-d trees** as the (defacto) standard of creating and maintaining a *k*-NN model. In the rest of this post we will have a look at how the algorithm works and explore it with the help of that little visualisation the puffins came up with. Just to warn you, it is not in the least bug free or complete, so I'd love to hear any bug reports and/or suggestions in the comments.

## The Theory
The **k-d tree** (*k-d* is short for *k*-dimensional) is one of best know indices for speeding up the prediction process of *k*-NN models. We are using a one-off computation to create the index and hence make retrieval more efficient. 
So in the example the puffins came up with, we will look at their `speed` and `strength` to see if they can get up a small cliff (I know they are really competitive when it comes to stupid things). So `speed` and `strength` will be our *descriptive features*, while `fly` (i.e. if they manage to fly up, and fly is a really generous term here) is our *target feature*. So the trick is to split the dataset in the middle and pick the median of your first feature as the root node, then alternatively split the remaining dataset while alternating the featues at each level until you arrive at a leaf node. Then go back a level and see if there is the other branch left to split, and so on and so on, until you arrive back at the root. Now you should have a nice binary tree, with alternate splits for each of your features on every level. Sounds weird? OK, let's look at our puffin example ...

## Our Example
The puffins k-d tree, like every proper k-d tree, has two visual areas. 1) The feature space (you can click into it to select a random puffin, with the attributes represented on the two axes for speed and strength) and 2) the tree itself. Every time you either click on the feature space or type your own values, the new puffin will appear on the feature space with a line that represents the split on the currently used feature (so the first puffin will split by speed, the second by strength, then speed again, etc.). This will automatically trigger the tree to create a new node with the puffin you specified. You will see the specifics of your split every time a new puffin appears. You can also decide if your new puffin can "fly" or not by either selecting the right radio button or clicking on your puffin once it's there (`green` puffin means it flies, `red` means she won't quite make it). So the colour of the puffin is our *target feature*.
But I bet you will get the gist once you try playing around a bit with the user interface, so why not just give it a go?

<!-- Copy and Paste Me -->
<div class="glitch-embed-wrap" style="height: 420px; width: 100%;">
  <iframe
    src="https://glitch.com/embed/#!/embed/k-d-tree?path=script.js&previewSize=100"
    title="k-d-tree on Glitch"
    allow="geolocation; microphone; camera; midi; vr; encrypted-media"
    style="height: 100%; width: 100%; border: 0;">
  </iframe>
</div>

## Conclusion

