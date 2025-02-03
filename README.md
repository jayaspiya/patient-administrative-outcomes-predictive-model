# Patient Adminstrative Outcomes Predictions

## Workflow Design

```mermaid
---
title: Patient Adminstrative Outcomes Predictions
---
flowchart TD
    subgraph Bronze
        bronze.resources
    end
    subgraph Silver
        silver.encounter
        silver.patient
        silver.condition
        silver.condition-standard
        silver.condition-risk
        silver.condition-rollup
    end
    subgraph Gold
        gold.encounter
    end

    bronze.resources --> silver.encounter
    bronze.resources --> silver.patient
    bronze.resources --> silver.condition
    silver.condition --> silver.condition-standard
    silver.condition-standard --> silver.condition-risk
    silver.condition-risk --> silver.condition-rollup
    silver.condition-rollup --> gold.encounter
    silver.patient --> gold.encounter
    silver.encounter --> gold.encounter
```