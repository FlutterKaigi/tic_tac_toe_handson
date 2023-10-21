import DefaultTheme from 'vitepress/theme'
import './custom.css'
import BaseProfile from '../components/BaseProfile.vue'

export default {
  ...DefaultTheme,
  enhanceApp({ app }) {
    app.component('BaseProfile', BaseProfile)
  }
}
