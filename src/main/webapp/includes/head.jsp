<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<script>
  tailwind.config = {
    theme: {
      extend: {
        fontFamily: {
          sans: ['Inter', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'sans-serif'],
        },
        colors: {
          ink: { DEFAULT: '#1d1d1f', muted: '#6e6e73', faint: '#86868b' },
          accent: { DEFAULT: '#0071e3', hover: '#0077ed', soft: 'rgba(0,113,227,0.12)' },
          surface: { DEFAULT: '#ffffff', muted: '#f5f5f7', glass: 'rgba(255,255,255,0.72)' },
          danger: { DEFAULT: '#ff3b30', soft: 'rgba(255,59,48,0.12)' },
          success: { DEFAULT: '#34c759', soft: 'rgba(52,199,89,0.12)' },
        },
        borderRadius: {
          '2xl': '1rem',
          '3xl': '1.25rem',
          '4xl': '1.5rem',
        },
        boxShadow: {
          soft: '0 2px 16px rgba(0,0,0,0.06)',
          'soft-md': '0 4px 24px rgba(0,0,0,0.07)',
          'soft-lg': '0 12px 40px rgba(0,0,0,0.08)',
          glow: '0 0 0 1px rgba(0,0,0,0.04), 0 2px 16px rgba(0,0,0,0.06)',
        },
        backdropBlur: {
          xs: '2px',
        },
      },
    },
  };
</script>
<style>
  html { scroll-behavior: smooth; }
  body {
    font-feature-settings: 'cv02', 'cv03', 'cv04', 'cv11';
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
  .glass-panel {
    background: rgba(255, 255, 255, 0.72);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    border: 1px solid rgba(255, 255, 255, 0.6);
  }
  .glass-nav {
    background: rgba(251, 251, 253, 0.8);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);
  }
  .btn-primary, .btn-secondary, .btn-danger, .btn-success, .btn-ghost {
    display: inline-flex; align-items: center; justify-content: center; gap: 0.5rem;
    border-radius: 1rem; font-size: 0.875rem; transition: all 0.2s ease;
    cursor: pointer; text-decoration: none; border: none;
  }
  .btn-primary {
    padding: 0.625rem 1.25rem; font-weight: 600; color: #fff;
    background: #0071e3; box-shadow: 0 2px 16px rgba(0,0,0,0.06);
  }
  .btn-primary:hover { background: #0077ed; box-shadow: 0 4px 24px rgba(0,0,0,0.07); }
  .btn-primary:active { transform: scale(0.98); }
  .btn-primary:disabled { opacity: 0.5; pointer-events: none; }
  .btn-secondary {
    padding: 0.625rem 1.25rem; font-weight: 500; color: #1d1d1f;
    background: #fff; border: 1px solid rgba(0,0,0,0.1);
    box-shadow: 0 0 0 1px rgba(0,0,0,0.04), 0 2px 16px rgba(0,0,0,0.06);
  }
  .btn-secondary:hover { background: #f5f5f7; border-color: rgba(0,0,0,0.15); }
  .btn-secondary:active { transform: scale(0.98); }
  .btn-danger { padding: 0.5rem 1rem; font-weight: 600; color: #fff; background: #ff3b30; box-shadow: 0 2px 16px rgba(0,0,0,0.06); }
  .btn-danger:hover { opacity: 0.9; }
  .btn-danger:active { transform: scale(0.98); }
  .btn-success { padding: 0.5rem 1rem; font-weight: 600; color: #fff; background: #34c759; box-shadow: 0 2px 16px rgba(0,0,0,0.06); }
  .btn-success:hover { opacity: 0.9; }
  .btn-success:active { transform: scale(0.98); }
  .btn-ghost { padding: 0.5rem 1rem; font-weight: 500; color: #0071e3; background: transparent; }
  .btn-ghost:hover { background: rgba(0,113,227,0.12); }
  .btn-ghost:active { transform: scale(0.98); }
  .input-field, .select-field {
    width: 100%; border-radius: 1rem; border: 1px solid rgba(0,0,0,0.1);
    background: #fff; padding: 0.625rem 1rem; font-size: 0.875rem; color: #1d1d1f;
    box-shadow: 0 0 0 1px rgba(0,0,0,0.04), 0 2px 16px rgba(0,0,0,0.06);
    outline: none; transition: all 0.2s ease;
  }
  .input-field::placeholder { color: #86868b; }
  .input-field:focus, .select-field:focus {
    border-color: rgba(0,113,227,0.4);
    box-shadow: 0 0 0 4px rgba(0,113,227,0.12);
  }
  .select-field { width: auto; }
  .card {
    border-radius: 1.5rem; border: 1px solid rgba(0,0,0,0.06);
    background: #fff; box-shadow: 0 2px 16px rgba(0,0,0,0.06);
    transition: all 0.3s ease;
  }
  .card-hover:hover { transform: translateY(-4px); box-shadow: 0 12px 40px rgba(0,0,0,0.08); }
  .table-shell {
    overflow: hidden; border-radius: 1.5rem; border: 1px solid rgba(0,0,0,0.06);
    background: #fff; box-shadow: 0 2px 16px rgba(0,0,0,0.06);
  }
  .data-table { width: 100%; font-size: 0.875rem; }
  .data-table thead th {
    background: #f5f5f7; padding: 0.875rem 1rem; text-align: left;
    font-size: 0.75rem; font-weight: 600; text-transform: uppercase;
    letter-spacing: 0.05em; color: #6e6e73;
  }
  .data-table tbody td {
    border-top: 1px solid rgba(0,0,0,0.04); padding: 0.875rem 1rem;
    color: #1d1d1f; vertical-align: middle;
  }
  .data-table tbody tr { transition: background 0.15s ease; }
  .data-table tbody tr:hover { background: rgba(245,245,247,0.6); }
  .form-label {
    display: block; margin-bottom: 0.375rem; font-size: 0.8125rem;
    font-weight: 500; color: #6e6e73;
  }
  input[readonly] {
    background-color: #f5f5f7 !important; cursor: not-allowed; color: #6e6e73;
  }
  .page-bg {
    background:
      radial-gradient(ellipse 80% 50% at 50% -20%, rgba(0, 113, 227, 0.08), transparent),
      linear-gradient(180deg, #fbfbfd 0%, #f5f5f7 100%);
    min-height: 100vh;
  }
  .building-gallery-slot {
    aspect-ratio: 4 / 3;
  }
  .building-gallery-slot.is-empty .gallery-img { display: none; }
  .building-gallery-slot.is-empty .gallery-placeholder { display: flex; }
  .building-gallery-slot .gallery-placeholder { display: none; }
  #page-loader {
    position: fixed; inset: 0; z-index: 9999;
    display: flex; align-items: center; justify-content: center;
    background: #fbfbfd;
    transition: opacity 0.35s ease, visibility 0.35s ease;
  }
  #page-loader.hidden-loader {
    opacity: 0; visibility: hidden; pointer-events: none;
  }
  .spinner {
    width: 32px; height: 32px;
    border: 2px solid rgba(0,113,227,0.15);
    border-top-color: #0071e3;
    border-radius: 50%;
    animation: spin 0.7s linear infinite;
  }
  @keyframes spin { to { transform: rotate(360deg); } }
  [data-animate] { opacity: 0; }
</style>
<script src="https://cdn.jsdelivr.net/npm/motion@11.11.17/dist/motion.js"></script>
