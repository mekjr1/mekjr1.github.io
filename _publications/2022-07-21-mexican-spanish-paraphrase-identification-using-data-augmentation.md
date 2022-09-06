# Abstract
Reorganizing words in a passage using synonyms and different words without changing the main
message delivered in the original sentence is called paraphrasing. Simplifying, clarification or taking
quotes, etc. In this paper, we address a Paraphrase Identification model for Mexican Spanish text pairs.
A data augmentation step was done using Google Translate API, and then three different similarity
algorithms, namely: Jaccard, Cosine, and Spacy similarity were used to create a similarity vector for each
text pair. The paraphrase identification task was modeled as binary classification of text pairs into two
classes, namely: Paraphrases and Not-Paraphrases. The proposed methodology with voting classifier of
three machine learning classifiers obtained a F1-score of 0.8754 for paraphrases category.

# Keywords
Paraphrase, Spanish, Similarity, Data Augmentation

[Download paper here](http://ceur-ws.org/Vol-3180/paper.pdf)

## Recommended citation: 

```{=latex}
@inproceedings{ArifEtAl:CLEF2022,
title = {},
author = {Abdul Gafar Manuel Meque and Fazlourrahman Balouchzahi and Grigori Sidorov and Alexander Gelbukh},
pages = {--},
url = {http://ceur-ws.org/},
crossref = {IBERLEF2022},
}
```