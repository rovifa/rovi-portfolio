# Rovi Fauzan Akbar — Portfolio (Astro)

Situs portofolio, dikonversi dari [halaman Notion](https://app.notion.com/p/3b0f50b18a4b81a0ad6cfea050e8eb3b). Dibangun dengan [Astro](https://astro.build) — output statis, tanpa framework JS berat, cepat di-deploy ke Vercel.

## Catatan penting

Project ini ditulis manual (bukan hasil `npm create astro`) karena sandbox tempat saya kerja tidak punya akses ke npm registry, jadi saya belum sempat menjalankan `npm install` / `npm run build` untuk verifikasi langsung. Strukturnya sudah saya periksa manual (tag HTML seimbang, JSON valid, sintaks Astro standar), tapi **jalankan langkah di bawah dulu di komputermu untuk memastikan semuanya bersih** sebelum deploy. Kalau ada error, kirim pesan errornya ke saya, saya bantu perbaiki.

## Menjalankan di lokal

```bash
npm install
npm run dev
```

Buka `http://localhost:4321`.

## Build untuk production

```bash
npm run build
npm run preview   # opsional, cek hasil build sebelum deploy
```

Output ada di folder `dist/`.

## Struktur project

```
src/
  layouts/Layout.astro       -> shell HTML bersama (header, footer, script mermaid)
  components/CaseStudyCard.astro
  pages/
    index.astro               -> halaman utama (ringkasan, timeline, skills)
    case-studies/
      bifast.astro
      platform-library.astro
      mambu-estatement.astro
      ottodigital.astro
      simulator.astro
      rag.astro
  styles/global.css           -> semua styling (dark theme)
```

Diagram arsitektur dirender di browser pakai [Mermaid.js](https://mermaid.js.org) (dimuat lewat CDN di `Layout.astro`), jadi tidak perlu build step tambahan untuk diagram.

## Deploy ke Vercel

Cara termudah — lewat GitHub:

1. Push folder ini ke repo GitHub baru.
2. Buka [vercel.com](https://vercel.com) → **Add New Project** → import repo tadi.
3. Vercel otomatis mendeteksi Astro (framework preset "Astro"), tidak perlu ubah build settings apa pun (default: `npm run build`, output `dist`).
4. Klik **Deploy**.

Atau lewat CLI, tanpa GitHub:

```bash
npm install -g vercel
vercel login
vercel        # deploy preview
vercel --prod # deploy production
```

## Update konten

Semua konten ada langsung di file `.astro` masing-masing (bukan headless CMS), jadi edit teksnya langsung di file terkait lalu commit. Kalau ada studi kasus baru dari Notion, cukup duplikat salah satu file di `src/pages/case-studies/`, sesuaikan konten dan diagram mermaid-nya (kalau ada), lalu tambahkan entri baru di array `caseStudies` pada `src/pages/index.astro`.
