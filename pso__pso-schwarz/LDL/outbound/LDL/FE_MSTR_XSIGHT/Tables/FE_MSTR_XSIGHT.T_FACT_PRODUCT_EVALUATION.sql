CREATE TABLE IF NOT EXISTS ldl_fe_mstr_xsight.t_fact_product_evaluation (
market_research_prod_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the product.'),
im_sortiment_marke BIGNUMERIC(38,0) DEFAULT 0,
im_sortiment_em BIGNUMERIC(38,0) DEFAULT 0,
regional_saisonal BIGNUMERIC(38,0) DEFAULT 0,
andere_verpackungsgr_m_em BIGNUMERIC(38,0) DEFAULT 0,
aktionsartikel_in_out BIGNUMERIC(38,0) DEFAULT 0,
vorschlag_nis_marke BIGNUMERIC(38,0) DEFAULT 0,
vorschlag_nis_eigenmarke BIGNUMERIC(38,0) DEFAULT 0,
vorschlag_nis_aktion_in_out BIGNUMERIC(38,0) DEFAULT 0,
vorschlag_nis_aktion_pv BIGNUMERIC(38,0) DEFAULT 0,
nicht_erhaeltlich BIGNUMERIC(38,0) DEFAULT 0,
PRIMARY KEY (market_research_prod_sid) NOT ENFORCED
);