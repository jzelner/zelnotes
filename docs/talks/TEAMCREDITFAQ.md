# Adding Team Member Credits to Slides made in Reveal.js
## Adding Credit Page
Copy the following code into your slide:
```
<div class="teamPicsDiv">
 <!-- Jon -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/jon.jpg">
  <a class="teamName" href="https://epibayes.io/author/jon-zelner/" target="_blank">Jon Zelner</a>
 </div>
 <!-- Hannah -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/hannah.png">
  <a class="teamName" ref="https://epibayes.io/author/hannah-steinberg/" target="_blank">Hannah Steinberg</a>
 </div>
 <!-- Joey -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/joey.png">
 <a class="teamName" href="https://epibayes.io/author/joey-dickens/" target="_blank">Joey Dickens</a>
 </div>
 <!-- Kelly -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/kelly.png">
  <a class="teamName" href="https://epibayes.io/author/kelly-broen/" target="_blank">Kelly Broen</a>
 </div>
 <!-- Krzysztof -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/krzysztof.jpg">
  <a class="teamName" href="https://epibayes.io/author/krzysztof-sakrejda/" target="_blank">Krzysztof Sakrejda</a>
 </div>
 <!-- Paul -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/paul.jpg">
  <a class="teamName" href="https://epibayes.io/author/paul-delamater/" target="_blank">Paul Delamater</a>
 </div>
 <!-- Ramya -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/ramya.png">
  <a class="teamName" href="https://epibayes.io/author/ramya-naraharisetti/"  target="_blank">Ramya Naraharisetti</a>
 </div>
 <!-- Rob -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/robert.jpg">
  <a class="teamName" href="https://epibayes.io/author/rob-trangucci/" target="_blank">Rob Trangucci</a>
 </div>
 <!-- Stephanie -->
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/stephanie.png">
  <a class="teamName" href="https://epibayes.io/author/stephanie-choi/" target="_blank">Stephanie Choi</a>
 </div>
</div>
```

## Adding Individual Member Credits
Copy the following code into your slide:
```
<div class="teamCredit">
 <div class="teamMember">
  <img class="teamPic" src="../images/labmembers/<MEMBER PICTURE>">
  <a class="teamName" href="<LINK TO LAB MEMBER PROFILE>" target="_blank">MEMBER NAME</a>
 </div>
</div>
```
**EASY ADDING:** Copy the "teamMember" div from the credit page, then wrap it in a div with the class, "teamCredit"

## Important Style Notes
The following CSS **MUST** be present for this to display properly (currently located at the bottom of the ```styles.css``` file in the ```epid684``` folder):
```

/* team members slide */
.teamPicsDiv{
    width: 100%;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
    grid-auto-rows: minmax(100px, auto);
}
.teamMember{
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
}
.teamName{
    font-size: 1rem !important;
    font-weight: bold !important;
    text-decoration: underline !important;
}

.teamPic{
    height: 100px;
    margin: 0 !important;
    margin-bottom: 5px !important;
    border-radius: 50% !important;
}

/* for crediting team members on slide */
.teamCredit{
    display: block;
    width: auto;

    /* fixed position takes the block out of the DOM 
    (other elements aren't impacted by where this block is)*/
    position: fixed;

    /* right-aligned and top-aligned
    (change right to left: 0; to move into left corner) */
    right: 0;
    top: 0;

    /* gives the block a translucent background color */
    background-color: rgba(192, 164, 130, 0.445);

    /* contents are snugly within the block */
    padding: 10px !important;
}
.teamCredit > .teamMember {
    width: 100%;
}
.teamCredit > .teamMember > .teamPic{
    width: 80px !important;
    height: 80px !important;
}
```
### "Can I move the team member credit to the bottom left/right corners?"
***NO***, because for some reason, the slide element's height extends beyond the height of the viewing window.
This means that if you set the attribute ```top: 0;``` to ```bottom: 0;```, the team credit block disappears off screen. I'll try to find a working solution, but for now the answer is NO.

### "Why is the credit covering page content?"
***Because it's a fixed element.*** ```position: fixed;``` takes the block out of the document flow and [ignores all other content positions](https://www.w3schools.com/css/css_positioning.asp). This is the easiest way to position this block in the corner. Otherwise, you will have to re-structure the slide header using ```flex``` or ```grid``` to space the elements across the top of the slide, and this might mess up slide creation and will most likely break the ```knit```.