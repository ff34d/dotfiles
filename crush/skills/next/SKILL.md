---
name: next
description: "Use for Next.js-specific work: App/Pages Router, routing, layouts, server/client components, server actions, rendering, caching, metadata, or deployment behavior. For general React topics, use the React skill instead unless Next.js behavior is involved."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Next.js Practices

First inspect the project's Next.js version, router structure, scripts, and existing conventions. Do not assume the App Router, caching defaults, or APIs from a different Next.js release.

## Routing and component boundaries

- Follow the router already used by the relevant part of the project (`app/` or `pages/`). Do not migrate routers as part of an unrelated task.
- In the App Router, prefer Server Components by default. Add `'use client'` only where browser APIs, client-side state/effects, or client-only libraries require it; keep the client boundary as narrow as practical.
- Do not pass non-serializable values across Server/Client Component boundaries. Keep secrets and server-only modules out of client bundles.
- Use layouts, loading/error boundaries, route handlers, and metadata APIs according to the installed version and route structure.
- In the Pages Router, follow its data-fetching and API-route model rather than applying App Router patterns blindly.

## Data, caching, and security

- Decide where data should be fetched based on runtime needs, credentials, latency, and whether the result must be interactive. Avoid duplicate requests caused by fetching the same data in multiple layers.
- Treat caching and revalidation as explicit behavior. Check the installed version's defaults before relying on them; configure invalidation when data freshness matters.
- Keep credentials, private environment variables, authorization checks, and privileged operations server-side. A hidden UI control is not access control.
- Validate route params, form input, and external data at the appropriate boundary. Handle expected errors with the project's established patterns.
- Use Server Actions only for appropriate server mutations, validate their inputs, and authorize every sensitive operation. Do not assume that an action is private because it is not exposed as a conventional API route.

## Performance and assets

- Use framework image/font/navigation tools when they fit the use case and project setup; do not force them where they add no value.
- Avoid unnecessary client JavaScript, broad client boundaries, duplicate fetching, and unmeasured memoization.
- Follow the project's deployment/runtime constraints when using Node APIs, edge runtimes, middleware/proxy features, or filesystem access.

## Verification

Check the relevant route in its actual rendering mode, loading/error/empty states, authorization, and cache invalidation. After a coherent batch of related edits, run the relevant build/typecheck once at a useful checkpoint rather than after every line or tool action; rerun after relevant fixes or before completion as risk warrants. Do not make version-specific claims without checking the installed version or repository documentation.
