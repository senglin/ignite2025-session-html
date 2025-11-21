---
agent: 'agent'
description: 'Create a visualization for only sessions that have on-demand videos and presentation slides available.'
---
file.json is the file that contains the data from 'https://api-v2.ignite.microsoft.com/api/session/all/en-US' using the curl script in curl.sh.

Use the attributes in the json file to create 2 visualizations, specifically title, description, aiDescription, sessionCode, speakerNames, startdatetime, durationInMinutes, onDemand, and slideDeck.

Create a visualization of which sessions have on demand videos (aka onDemand field has a valid url link). Display the link, including title, description, aiDescription, sessionCode, speakerNames, Date & Time (taken from startdatetime) and Duration for each session.

Use startdatetime attribute to extract Date & Time.

"null" is not a valid url.

In a separate tab, create a visualization of which sessions have slide decks (aka slideDeck field has a valid url link). Display the link, including title, description, aiDescription, sessionCode, speakerNames, Day & Time (taken from startdatetime) and Duration for each session.

Each tab should have the total count of sessions displayed at the top.
Each session entry should have a numbered index.

Do not truncate both description and aiDescription.

There should only be 2 tabs: Sessions with On-Demand Videos and Sessions with Slide Decks.

Create me a standalone html page that is able to accept a json file, and provide the same visualization.

There should be instructions to download from 'https://api-v2.ignite.microsoft.com/api/session/all/en-US' and saving that as a JSON file. The page should support dragging and dropping the file into the page, as well as a file picker.

Follow the style using the screenshot in style.png.
