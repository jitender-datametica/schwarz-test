CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_fact_product_evaluation (market_research_prod_sid, im_sortiment_marke,
im_sortiment_em, regional_saisonal, andere_verpackungsgr_m_em, aktionsartikel_in_out, vorschlag_nis_marke,
vorschlag_nis_eigenmarke, vorschlag_nis_aktion_in_out, vorschlag_nis_aktion_pv, nicht_erhaeltlich) AS SELECT I.market_research_prod_sid
 ,
  CASE
  WHEN E.im_sortiment_marke = 1
  THEN 1
  ELSE 0
  END AS im_sortiment_marke,
  CASE
  WHEN E.im_sortiment_em = 1
  THEN 1
  ELSE 0
  END AS im_sortiment_em,
  CASE
  WHEN E.regional_saisonal = 1
  THEN 1
  ELSE 0
  END AS regional_saisonal,
  CASE
  WHEN E.andere_verpackungsgr_m_em = 1
  THEN 1
  ELSE 0
  END AS andere_verpackungsgr_m_em,
  CASE
  WHEN E.aktionsartikel_in_out = 1
  THEN 1
  ELSE 0
  END AS aktionsartikel_in_out,
  CASE
  WHEN E.vorschlag_nis_marke = 1
  THEN 1
  ELSE 0
  END AS vorschlag_nis_marke,
  CASE
  WHEN E.vorschlag_nis_eigenmarke = 1
  THEN 1
  ELSE 0
  END AS vorschlag_nis_eigenmarke,
  CASE
  WHEN E.vorschlag_nis_aktion_in_out = 1
  THEN 1
  ELSE 0
  END AS vorschlag_nis_aktion_in_out,
  CASE
  WHEN E.vorschlag_nis_aktion_pv = 1
  THEN 1
  ELSE 0
  END AS vorschlag_nis_aktion_pv,
  CASE
  WHEN E.nicht_erhaeltlich = 1
  THEN 1
  ELSE 0
  END AS nicht_erhaeltlich
FROM ldl_p_lew_core_ac.v_market_research_product AS I
 LEFT JOIN ldl_fe_mstr_xsight.t_fact_product_evaluation AS E ON I.market_research_prod_sid = E.market_research_prod_sid;