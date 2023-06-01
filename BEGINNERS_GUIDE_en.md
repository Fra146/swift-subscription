# A beginner's guide to using this template.

This guide will walk you through the steps to use this template. Even though this guide is made for beginners in using github, and setting up advanced swift playground apps, we'll still include links and references to further study advanced techniques.

## Prerequisites

- A GitHub account made on [GitHub.com](https://github.com/join).
- Basic understanding in json files

## Getting Started

1. Log into your GitHub account and go to the [main template page](https://github.com/Fra146/swift-subscription).
2. Click the green `Use this template` button and choose `Create a new repository` from the dropdown menu.

## Setting Up The Repository

1. Give your new repository a name (and optionally, a description)
> If you're a GitHub Free user you will have to use `NAME_OF_YOUR_ACCOUNT.github.io` as the name of your repository and set your repository to public in order to use GitHub Pages.
> If you're a student, you might be eligible to a free GitHub Pro subscription by enrolling in the [GitHub Campus Program](https://education.github.com/).
2. Access your new repository and click on `Settings`. Choose `Pages` from the menu on the left side. Choose `master` as your source branch and press `Save`.
3. Your GitHub Pages website will now be available at `https://NAME_OF_YOUR_ACCOUNT.github.io`. If not, wait around 10 minutes and try to access the website again. If you're encountering further issues, check [GitHub Pages Documentation](https://docs.github.com/en/pages).
> You can safely delete the provided void folder

![image](https://github.com/Fra146/swift-subscription/assets/61921751/7ca60d9c-1b2b-4590-9824-eec9e1ca2b85)

## Upload a swift playgrounds project

1. Prepare your exported version of the swift playgrounds project by opening the project on swift playgrounds, then choosing `Three dots on top -> Advanced -> Export`. In the fields write a custom project subtitles at your choice, then as your contents ID write the reverse DNS of your github pages deployment and a common project name. In my case, it'll be `io.github.fra146.void` since my project common name is void, and the website can be found at `fra146.github.io`.
2. Create a new folder for your project by pressing `Add file` from the main page of your repository, then `Create new file`. On `Name your file...` type `COMMON_PROJET_NAME/.` (replace COMMON_PROJECT_NAME with the common project name you'll use during the deployment. Following my example in step one, I'd use `void`) and then, on the new field that appears, `placeholder.txt`. Scroll down and press `Commit new file`
> For advanced usage of Git, check the [documentation](https://git-scm.com/doc).
3. In your new folder, press `Add file`, then `Upload file`. Now **upload a compressed (.zip) version of the exported playground**, named `COMMON_PROJECT_NAME.playgroundbook.zip`. In my case, I'll use `void.playgroundbook.zip`
![image](https://github.com/Fra146/swift-subscription/assets/61921751/81d0978e-f7bf-4ec1-8df0-90021cd4d2a7)

## Customize your page

For each project, in its own folder, you can add a few images to enrich the download page.
- The thumbnail must be of exactly 902x678 pixels (File name example, thumb.png)
- The banner must be of exactly of 1080x400 pixels (File name example, banner.png)
- The preview images must be of exactly (File name example, prev1.png, prev2.png, prev3.png, ...)

## Editing the root feed.json

Feed.json will contain information about each and every playground provided with the release.
Check the provided feed.json to understand what to put in fields.
> In feedIdentifier put the reverse DNS of the root of the github pages. In my example I'll use `io.github.fra146`
> In each contentIdentifier put the reverse DNS of the location of the playground. This must start with the feedIdentifier. In my example I'll use `io.github.fra146.void`

## Checking the published website

Check on the right side of the root of the GitHub Repository for a `Environments` part. Press on `github-pages`, then `View deployment`

## Sharing the playground subscription

To add the playground subscription to your own playground app, go to Swift Playground, open the `Other playground` screen, scroll down and press `Subscribe by URL`. Here, you'll have to add the precise location to the feed.json. In my case, that'll be `https://fra146.github.io/feed.json`.
![image](https://github.com/Fra146/swift-subscription/assets/61921751/c977325a-fa0d-474d-b2fe-4dcbfb7fa013)
