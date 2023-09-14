import { defineConfig } from 'vitepress'
import markdownItLinkPreview from '@nekohack/markdown-it-link-preview'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: `FlutterKaigi 2023 ハンズオン`,
  description: `ハンズオンでご紹介のあった資料を中心に記録しています。`,
  head: [
    [
      `meta`,
      {
        hid: `description`,
        name: `description`,
        content: `FlutterKaigi 2023 ハンズオンでご紹介のあった資料を中心に記録しています。`
      }
    ],
    [
      `meta`,
      {
        hid: `title`,
        name: `title`,
        content: `FlutterKaigi 2023 ハンズオン`
      }
    ],
    [
      `meta`,
      {
        hid: `og:type`,
        name: `og:type`,
        content: `website`
      }
    ],
    [
      `meta`,
      {
        hid: `og:description`,
        name: `og:description`,
        content: `FlutterKaigi 2023 ハンズオンでご紹介のあった資料を中心に記録しています。`
      }
    ],
    [
      `meta`,
      {
        hid: `og:title`,
        name: `og:title`,
        content: `FlutterKaigi 2023 ハンズオン`
      }
    ],
    [
      `meta`,
      {
        hid: `og:url`,
        name: `og:url`,
        content: `https://flutterkaigi-2023-workshop.netlify.app`
      }
    ],
    [
      `meta`,
      {
        hid: `og:image`,
        name: `og:image`,
        content: `https://flutterkaigi-2023-workshop.netlify.app/top.png`
      }
    ],
    [
      `meta`,
      {
        hid: `twitter:description`,
        name: `twitter:description`,
        content: `FlutterKaigi 2023 ハンズオンでご紹介のあった資料を中心に記録しています。`
      }
    ],
    [
      `meta`,
      {
        hid: `twitter:title`,
        name: `twitter:title`,
        content: `FlutterKaigi 2023 ハンズオン`
      }
    ],
    [
      `meta`,
      {
        hid: `twitter:card`,
        name: `twitter:card`,
        content: `summary_large_image` // ex: summary, summary_large_image
      }
    ],
    [
      `meta`,
      {
        hid: `twitter:site`,
        name: `twitter:site`,
        content: `@FlutterKaigi`
      }
    ],
    [
      `meta`,
      {
        hid: `twitter:creator`,
        name: `twitter:creator`,
        content: `@FlutterKaigi`
      }
    ],
    [
      `meta`,
      {
        hid: `twitter:site`,
        name: `twitter:site`,
        content: `@FlutterKaigi`
      }
    ],
    [
      `meta`,
      {
        hid: `twitter:image`,
        name: `twitter:image`,
        content: `https://flutterkaigi-2023-workshop.netlify.app/top.png`
      }
    ],
  ],
  base: `/`,
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      {
        text: `Outline`,
        items: [
          {
            text: `Riverpod の紹介`,
            link: `/outline/chapter1.md`
          },
          {
            text: `アプリケーションの基本構造とゲームロジック`,
            link: `/outline/chapter2.md`
          },
          {
            text: `UI の作成`,
            link: `/outline/chapter3.md`
          },
          {
            text: `Riverpod の導入`,
            link: `/outline/chapter4.md`
          },
          {
            text: `Firestore を用いたリアルタイム対戦機能 (チャレンジ企画)`,
            link: `/outline/chapter5.md`
          }
        ]
      },
      {
        text: `Past Kaigis`,
        items: [
          { text: `FlutterKaigi 2022`, link: `https://flutterkaigi-2022-workshop.netlify.app/` },
          { text: `FlutterKaigi 2021`, link: `https://flutterkaigi-2021-workshop.netlify.app/` }
        ]
      }
    ],
    sidebar: [
      {
        text: `Outline`,
        items: [
          {
            text: `Riverpod の紹介`,
            link: `/outline/chapter1.md`
          },
          {
            text: `アプリケーションの基本構造とゲームロジック`,
            link: `/outline/chapter2.md`
          },
          {
            text: `UI の作成`,
            link: `/outline/chapter3.md`
          },
          {
            text: `Riverpod の導入`,
            link: `/outline/chapter4.md`
          },
          {
            text: `Firestore を用いたリアルタイム対戦機能 (チャレンジ企画)`,
            link: `/outline/chapter5.md`
          }
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/FlutterKaigi/tic_tac_toe_handson' },
      { icon: 'twitter', link: 'https://twitter.com/FlutterKaigi' }
    ]
  },
  markdown: {
    toc: { level: [1, 2] },
    config: (md) => {
      md.use(markdownItLinkPreview)
    }
  }
})
