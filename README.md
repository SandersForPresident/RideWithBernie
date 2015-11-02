**Update:** If you're just getting here and interested in helping, please do 2 things:

1. Glance through this Readme so you have an idea of what the project is about
2. [Fill out a row for yourself on this introduction spreadsheet](https://docs.google.com/spreadsheets/d/15B-g3MRpAffFGhvdjjrrCutL304OMWZMSekVZ_lWqI8/edit#gid=0)

---

### Background

Many devs have been talking about a ride-sharing app of some kind for the Sanders campaign. Some seemed to be thinking about more of a "ride-share to the local debate party" app, and others had been thinking more of a "short-notice uber ride to the polls on election day" app. It seems obvious that both would be great, and that they're also quite similar. I'm going to posit that we should **start** by building the "ride-share" app, and then (if successful), move on to the "uber" idea.

### Reasoning

Without going into [too much detail](https://docs.google.com/document/d/1u6vVa1z7Er3byhF02qBPr_wAvMqqADjDAp3AKvZJKBI/edit#) - it's just much easier to build the "ride-share" app than the "uber" app. We also can test it **immediately**, because there are already tons of events happening all over the country. If we can build an app that does that successfully, and we're actually helping 1000s of people get to more events, then that's already a huge victory. If we can take it one step further and help people get to the polls, then that's just incredible. But I'm thinking of it more as a "stretch-goal" for this project right now.

### The "Ride-share" app

So our first goal is to help people get to more events. The most important thing to realize is that we can't just build something and assume that people will start using it, we need to know exactly how we're going to get the word out, solicit feedback, and iterate on the product. Fortunately, there's already a [centralized repo of every Bernie event (map.berniesanders.com)](http://map.berniesanders.com/), built by @rcas, which has an [API](https://go.berniesanders.com/page/event/search_results?format=json&wrap=no&orderby%5B0%5D=date&orderby%5B1%5D=desc&event_type=0&mime=text/json&limit=4000&country=*). Best-case scenario here would be that everyone who needs a ride to one of those events is able to find one. That could be accomplished through an integration between a product we build and map.berniesanders.com, or it could be accomplished by simply generating Google Sheets for each event and linking to it, allowing people to fill in their info and find each other.

I'm assuming that there are volunteers who put together [volunteer resources](https://go.berniesanders.com/page/content/toolkit) like [this Guide on hosting a successful event](https://docs.google.com/document/d/1oOqWf5EGEP2ouCZUfPXJMYNTYL70uxh5Mcj3FUDlVeo/edit) and [this Guide on hosting a Debate Party](https://docs.google.com/document/d/1LuPzTLZHWDcCfZc0eHYS159sLO-92AKlcSamslCJ3GY/edit). We need to talk to these people! They're the ones who will actually get the word out about our project if it's working well.

The philosophy I'm running with here is that we should get products out into production as quickly as possible, even if it's literally just a Google Sheet. I'm sure we'll need to innovate on that in order to get to our final goal, but we're not helping anyone till we start helping anyone, and we'll learn as we go.

#### TODO:

I've started this repository with a few [Issues](https://github.com/kyletns/uberForSanders/issues), so please put discussion there!

- [Introduce ourselves!](https://github.com/kyletns/uberForSanders/issues/4)
- [Find the Bernie volunteers who help people organize events](https://github.com/kyletns/uberForSanders/issues/1)
- [Brainstorm the simplest, lightest product experience we can provide that accomplishes our goals](https://github.com/kyletns/uberForSanders/issues/2)
- [Brainstorm the simplest, lightest tools that we can use to build this thing](https://github.com/kyletns/uberForSanders/issues/3)

And of course, any other issues you come up with are welcome there, as well.
