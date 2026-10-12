CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_lil_lift_dm_chart15 (lift_cat_id, client_id, per_id, clnt_rtl_id,
clnt_rtl_lvl, currency_iso_cd, v_lidl_cat_ttshare, value_lidl, valuepot_lidl_cat_ttshare, valuepot_lidl, vpe_lidl_bar,
vpe_lidl, vpe_bar, vpe, vpe_gap_pp_bar, vpe_gap_pp, avp_lidl_share_bar, avp_lidl, rb, rb_lidl, prot_fg) AS SELECT
 lift_cat_id,
 client_id,
 per_id,
 rtl_id AS clnt_rtl_id,
 rtl_tp_id AS clnt_rtl_lvl,
 currency_iso_cd,
 valuelidlcattototalshare AS v_lidl_cat_ttshare,
 REPLACE(CAST(valuelidl AS STRING FORMAT '999,999,999,999,999,999,999,999'), ',', '.') AS value_lidl,
 valuepotlidlcattototalshare AS valuepot_lidl_cat_ttshare,
 REPLACE(CAST(valuepotentiallidl AS STRING FORMAT '999,999,999,999,999,999,999,999'), ',', '.') AS valuepot_lidl,
 valuepotentialexploitationlidl AS vpe_lidl_bar,
 REPLACE(CAST(valuepotentialexploitationlidl AS STRING FORMAT '999,999,999,999,999,999,999,999.9'), ',', '.') AS
 vpe_lidl,
 valuepotentialexploitation AS vpe_bar,
 REPLACE(CAST(valuepotentialexploitation AS STRING FORMAT '999,999,999,999,999,999,999,999.9'), ',', '.') AS vpe,
 vpegappp AS vpe_gap_pp_bar,
 REPLACE(CAST(vpegappp AS STRING FORMAT '999,999,999,999,999,999,999,999.9'), ',', '.') AS vpe_gap_pp,
 avplidlsharebar AS avp_lidl_share_bar,
 REPLACE(CAST(CASE
    WHEN addedvaluepotentiallidl > 0
    THEN ROUND(addedvaluepotentiallidl)
    ELSE NULL
    END AS STRING FORMAT '999,999,999,999,999,999,999,999'), ',', '.') AS avp_lidl,
 maxrawbuyer AS rb,
 maxrawbuyerlidl AS rb_lidl,
 0 AS prot_fg
FROM ldl_p_lew_core_ac.v_wawi_lil_lift_dm_chart15;