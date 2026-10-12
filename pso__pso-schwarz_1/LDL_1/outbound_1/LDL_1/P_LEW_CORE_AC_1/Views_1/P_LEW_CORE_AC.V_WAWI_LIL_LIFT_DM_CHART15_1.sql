/* #DescStart#
#$Revision: 7598 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_lil_lift_dm_chart15_1 (client_id, per_id, rtl_tp_id, lift_cat_id, rtl_id,
currency_iso_cd, valuelidlcattototalshare, valuelidl, valuepotlidlcattototalshare, valuepotentiallidl,
valuepotentialexploitationlidl, valuepotentialexploitation, vpegappp, avplidlsharebar, addedvaluepotentiallidl,
maxrawbuyer, maxrawbuyerlidl) AS SELECT client_id,
 per_id,
 rtl_tp_id,
 lift_cat_id,
 rtl_id,
 currency_iso_cd,
 valuelidlcattototalshare,
 valuelidl,
 valuepotlidlcattototalshare,
 valuepotentiallidl,
 valuepotentialexploitationlidl,
 valuepotentialexploitation,
 vpegappp,
 avplidlsharebar,
 addedvaluepotentiallidl,
 maxrawbuyer,
 maxrawbuyerlidl
FROM ldl_p_lew_core.t_wawi_lil_lift_dm_chart15_1;