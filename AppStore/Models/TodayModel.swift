//
//  TodayModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 18.03.2024.
//

import Foundation

struct Today {
    let featuredTitle: String
    let headTitle: String
    let detailTitle1: String
    let description1: String
    let detailTitle2: String
    let description2: String
    let imageName: String
}

let modelData: [Today] = [
    Today(featuredTitle: "VIAGEM" ,headTitle: "Explore the world\nwithout fear.", detailTitle1: "We can travel the world in search of beauty, but we will never find it if we do not carry it within us.", description1: "This is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", detailTitle2: "", description2: "", imageName: "image2"),
    Today(featuredTitle: "LIFE HACK" ,headTitle: "Utilizing your Time",detailTitle1: "All the tools and apps you need to intelligently organize your life the right way.", description1: "Great games are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.",detailTitle2: "\nHeroic adventure;",description2: "Battle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", imageName: "image3"),
    Today(featuredTitle: "HOLIDAYS" ,headTitle: "Travel on a Budget", detailTitle1: "Find out all you need to know on how to travel without packing everything!", description1: "", detailTitle2: "", description2: "", imageName: "image1"),
]
