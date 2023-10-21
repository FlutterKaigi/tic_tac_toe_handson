<script setup lang="ts">
const props = defineProps({
  avatarUrl: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  twitterUrl: {
    type: String,
    required: true,
  },
})
</script>

<template>
  <div class="root">
    <img :alt="name" :src="avatarUrl" width="80" height="80" decoding="async" />
    <div class="content">
      <h3>{{ name }}</h3>
      <p>{{ title }}</p>
      <div>
        <a :href="twitterUrl" target="_blank" rel="noopenner noreferrer">
          Follow
        </a>
      </div>
    </div>
  </div>
</template>

<style scoped>
.root {
  display: grid;
  grid-template-columns: auto 1fr;
  column-gap: 32px;
  padding-bottom: 16px;
}

.root img {
  border-radius: 50%;
}

.content {
  display: grid;
  gap: 8px;
}

.content h3 {
  padding: 0;
  margin: 0;
  font-size: 1.1em;
  font-weight: 700;
}

.content p {
  padding: 0;
  margin: 0;
  font-size: .9rem;
  font-weight: 500;
  line-height: 1.7;
}

.content a {
  padding: 4px 8px;
  margin: 0;
  color: #65717b;
  border: 1px solid #65717b;
  border-radius: 25px;
  text-decoration: none;
  cursor: pointer;
}
</style>
