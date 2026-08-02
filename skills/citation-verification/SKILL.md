---
name: citation-verification
description: Verify scholarly citations, bibliographic metadata, DOI or PMID identifiers, quotations, and claim-to-source support. Use when auditing a manuscript, checking whether references are real, reconciling citations after revision, or building an evidence table before submission.
---

# Citation Verification

Verify citations against primary bibliographic records and the cited source itself. Never treat a search snippet, model memory, or another paper's bibliography as final verification.

## Workflow

1. Extract every in-text citation, quotation, numeric claim, and bibliography entry.
2. Normalize titles, authors, year, venue, volume, pages, DOI, PMID, arXiv ID, and URL.
3. Resolve metadata through current authoritative sources such as DOI registries, publisher pages, PubMed, Crossref, OpenAlex, or arXiv.
4. Open the source and confirm that it supports the exact nearby claim. Record page, section, figure, or table when available.
5. Classify each item as `verified`, `metadata mismatch`, `claim mismatch`, `duplicate`, `retracted/corrected`, or `unverified`.
6. Reconcile in-text citations with the bibliography and report missing or unused entries.

## Output

Return a verification table with citation key, normalized metadata, identifier, claim, source locator, status, and required action. Keep unresolved entries explicit; never invent missing metadata.
