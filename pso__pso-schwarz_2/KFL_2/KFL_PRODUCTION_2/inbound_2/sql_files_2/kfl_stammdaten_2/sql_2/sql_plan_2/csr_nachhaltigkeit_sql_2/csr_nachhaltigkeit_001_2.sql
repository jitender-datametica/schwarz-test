CREATE  VOLATILE TABLE _art_prod_group AS (
SELECT a.mandant_id,
       a.art_id,
       b.csr_produktgruppe_id
FROM DBP_DATA.art_wg_zu_per_2 a
JOIN DBP_ETL_PROCESS.csr_wg_produktgruppe_zu_2 b
  ON a.wg_id = b.wg_id AND
     a.arthiertyp_id = 2 AND
     a.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
WHERE b.wug_id IS NULL AND
      b.csr_produktgruppe_bez NOT LIKE '%/EM'
GROUP BY 1,2,3
);


INSERT INTO _art_prod_group
SELECT a.mandant_id,
       a.art_id,
       b.csr_produktgruppe_id
FROM DBP_DATA.art_wg_zu_per_2 a
JOIN DBP_ETL_PROCESS.csr_wg_produktgruppe_zu_2 b
  ON a.wg_id = b.wg_id AND
     a.wug_id = b.wug_id AND
     a.arthiertyp_id = 2 AND
     a.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
WHERE b.wug_id IS NOT NULL AND
      b.csr_produktgruppe_bez NOT LIKE '%/EM'
GROUP BY 1,2,3
;

INSERT INTO _art_prod_group
SELECT a.mandant_id,
       a.art_id,
       b.csr_produktgruppe_id
FROM DBP_DATA.art_wg_zu_per_2 a
JOIN DBP_ETL_PROCESS.csr_wg_produktgruppe_zu_2 b
  ON a.wg_id = b.wg_id AND
     a.arthiertyp_id = 2 AND
     a.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN DBP_DATA.art_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     c.eigenmarke_id <> ''
WHERE b.wug_id IS NULL AND
      b.csr_produktgruppe_bez LIKE '%/EM'
GROUP BY 1,2,3
;


INSERT INTO _art_prod_group
SELECT a.mandant_id,
       a.art_id,
       b.csr_produktgruppe_id
FROM DBP_DATA.art_wg_zu_per_2 a
JOIN DBP_ETL_PROCESS.csr_wg_produktgruppe_zu_2 b
  ON a.wg_id = b.wg_id AND
     a.wug_id = b.wug_id AND
     a.arthiertyp_id = 2 AND
     a.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN DBP_DATA.art_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     c.eigenmarke_id <> ''
WHERE b.wug_id IS NOT NULL AND
      b.csr_produktgruppe_bez LIKE '%/EM'
GROUP BY 1,2,3
;


DELETE FROM DBP_DATA.csr_produktgruppe_art_zu_2;


INSERT INTO DBP_DATA.csr_produktgruppe_art_zu_2 
        (mandant_id
        ,art_id
        ,csr_produktgruppe_id
        )
SELECT mandant_id,
       art_id,
       csr_produktgruppe_id
FROM _art_prod_group
;


CREATE  VOLATILE TABLE _step1 AS (
SELECT a.mandant_id,
       a.art_id,
       b.nachhaltigkeitslogo_id
FROM DBP_DATA.art_2 a
JOIN DBP_DATA.l_nachhaltigkeitslogo_2 b
  ON 1 = 1
);



CREATE  VOLATILE TABLE _step2 AS (
SELECT a.*
FROM _step1 a
LEFT JOIN DBP_DATA.art_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN b.bio_fg = 1 THEN 1001 END
LEFT JOIN DBP_DATA.art_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN c.fair_trade_fg = 1 THEN 1002 END
LEFT JOIN DBP_DATA.art_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN d.fcp_fg = 1 THEN 1003 END
LEFT JOIN DBP_DATA.art_2 e
  ON a.mandant_id = e.mandant_id AND
     a.art_id = e.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN e.rainforest_fg = 1 THEN 1004 END
LEFT JOIN DBP_DATA.art_2 f
  ON a.mandant_id = f.mandant_id AND
     a.art_id = f.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN f.utz_certified_fg = 1 THEN 1005 END
LEFT JOIN DBP_DATA.art_2 g
  ON a.mandant_id = g.mandant_id AND
     a.art_id = g.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN g.msc_fg = 1 THEN 1006 END
LEFT JOIN DBP_DATA.art_2 h
  ON a.mandant_id = h.mandant_id AND
     a.art_id = h.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN h.asc_fg = 1 THEN 1007 END
LEFT JOIN DBP_DATA.art_2 i
  ON a.mandant_id = i.mandant_id AND
     a.art_id = i.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN i.dolphin_safe_fg = 1 THEN 1008 END
LEFT JOIN DBP_DATA.art_2 j
  ON a.mandant_id = j.mandant_id AND
     a.art_id = j.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN j.fos_fg = 1 THEN 1009 END
LEFT JOIN DBP_DATA.art_2 k
  ON a.mandant_id = k.mandant_id AND
     a.art_id = k.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN k.fsc_fg = 1 THEN 1010 END
LEFT JOIN DBP_DATA.art_2 l
  ON a.mandant_id = l.mandant_id AND
     a.art_id = l.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN l.pefc_fg = 1 THEN 1011 END
LEFT JOIN DBP_DATA.art_2 m
  ON a.mandant_id = m.mandant_id AND
     a.art_id = m.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN m.blauer_engel_fg = 1 THEN 1012 END
LEFT JOIN DBP_DATA.art_2 n
  ON a.mandant_id = n.mandant_id AND
     a.art_id = n.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN n.euro_blume_fg = 1 THEN 1013 END
LEFT JOIN DBP_DATA.art_2 o
  ON a.mandant_id = o.mandant_id AND
     a.art_id = o.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN o.gots_fg = 1 THEN 1014 END
LEFT JOIN DBP_DATA.art_2 p
  ON a.mandant_id = p.mandant_id AND
     a.art_id = p.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN p.gots_proz_fg = 1 THEN 1015 END
LEFT JOIN DBP_DATA.art_2 q
  ON a.mandant_id = q.mandant_id AND
     a.art_id = q.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN q.gots_organ_fg = 1 THEN 1016 END
LEFT JOIN DBP_DATA.art_2 r
  ON a.mandant_id = r.mandant_id AND
     a.art_id = r.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN r.green_brands_fg = 1 THEN 1017 END
LEFT JOIN DBP_DATA.art_2 s
  ON a.mandant_id = s.mandant_id AND
     a.art_id = s.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN s.kon_nat_kosmetik_fg = 1 THEN 1018 END
LEFT JOIN DBP_DATA.art_2 t
  ON a.mandant_id = t.mandant_id AND
     a.art_id = t.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN t.natrue_fg = 1 THEN 1019 END
LEFT JOIN DBP_DATA.art_2 u
  ON a.mandant_id = u.mandant_id AND
     a.art_id = u.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN u.ohne_gentechnik_fg = 1 THEN 1020 END
LEFT JOIN DBP_DATA.art_2 v
  ON a.mandant_id = v.mandant_id AND
     a.art_id = v.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN v.rspo_fg = 1 THEN 1021 END
LEFT JOIN DBP_DATA.art_2 w
  ON a.mandant_id = w.mandant_id AND
     a.art_id = w.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN w.sustain_clean_fg = 1 THEN 1022 END
LEFT JOIN DBP_DATA.art_2 x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN x.bitrex_fg = 1 THEN 1023 END
LEFT JOIN DBP_DATA.art_2 y
  ON a.mandant_id = y.mandant_id AND
     a.art_id = y.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN y.eier_bh_fh_fg = 1 THEN 1024 END
LEFT JOIN DBP_DATA.art_2 z
  ON a.mandant_id = z.mandant_id AND
     a.art_id = z.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z.halal_fg = 1 THEN 1025 END
LEFT JOIN DBP_DATA.art_2 z1
  ON a.mandant_id = z1.mandant_id AND
     a.art_id = z1.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1.keimling_fg = 1 THEN 1026 END
LEFT JOIN DBP_DATA.art_2 z2
  ON a.mandant_id = z2.mandant_id AND
     a.art_id = z2.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z2.vegan_fg = 1 THEN 1027 END
LEFT JOIN DBP_DATA.art_2 z3
  ON a.mandant_id = z3.mandant_id AND
     a.art_id = z3.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z3.vegetarisch_fg = 1 THEN 1028 END
LEFT JOIN DBP_DATA.art_2 z4
  ON a.mandant_id = z4.mandant_id AND
     a.art_id = z4.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z4.bioland_fg = 1 THEN 1029 END
LEFT JOIN DBP_DATA.art_2 z5
  ON a.mandant_id = z5.mandant_id AND
     a.art_id = z5.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z5.demeter_fg = 1 THEN 1030 END
LEFT JOIN DBP_DATA.art_2 z6
  ON a.mandant_id = z6.mandant_id AND
     a.art_id = z6.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z6.dtb_einstieg_fg = 1 THEN 1031 END
LEFT JOIN DBP_DATA.art_2 z7
  ON a.mandant_id = z7.mandant_id AND
     a.art_id = z7.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z7.dtb_premium_fg = 1 THEN 1032 END
LEFT JOIN DBP_DATA.art_2 z8
  ON a.mandant_id = z8.mandant_id AND
     a.art_id = z8.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z8.freilandhaltung_fg = 1 THEN 1033 END
LEFT JOIN DBP_DATA.art_2 z9
  ON a.mandant_id = z9.mandant_id AND
     a.art_id = z9.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z9.gap_fg = 1 THEN 1034 END 
LEFT JOIN DBP_DATA.art_2 z10
  ON a.mandant_id = z10.mandant_id AND
     a.art_id = z10.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z10.gluten_fg = 1 THEN 1035 END 
LEFT JOIN DBP_DATA.art_2 z11
  ON a.mandant_id = z11.mandant_id AND
     a.art_id = z11.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z11.aquagap_fg = 1 THEN 1036 END 
LEFT JOIN DBP_DATA.art_2 z12
  ON a.mandant_id = z12.mandant_id AND
     a.art_id = z12.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z12.kaninchen_bh_fg = 1 THEN 1037 END 
LEFT JOIN DBP_DATA.art_2 z13
  ON a.mandant_id = z13.mandant_id AND
     a.art_id = z13.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z13.lactose_fg = 1 THEN 1038 END 
LEFT JOIN DBP_DATA.art_2 z14
  ON a.mandant_id = z14.mandant_id AND
     a.art_id = z14.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z14.marktfrisch_fg = 1 THEN 1039 END
LEFT JOIN DBP_DATA.art_2 z15
  ON a.mandant_id = z15.mandant_id AND
     a.art_id = z15.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z15.naturland_fg = 1 THEN 1040 END
LEFT JOIN DBP_DATA.art_2 z16
  ON a.mandant_id = z16.mandant_id AND
     a.art_id = z16.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z16.fsc_verpackung_fg = 1 THEN 1041 END
LEFT JOIN DBP_DATA.art_2 z17
  ON a.mandant_id = z17.mandant_id AND
     a.art_id = z17.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z17.tierwohl_fg = 1 THEN 1042 END
LEFT JOIN DBP_DATA.art_2 z18
  ON a.mandant_id = z18.mandant_id AND
     a.art_id = z18.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z18.qs_fg = 1 THEN 1043 END 
LEFT JOIN DBP_DATA.art_2 z19
  ON a.mandant_id = z19.mandant_id AND
     a.art_id = z19.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z19.gu_fg = 1 THEN 1044 END
LEFT JOIN DBP_DATA.art_2 z20
  ON a.mandant_id = z20.mandant_id AND
     a.art_id = z20.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z20.gts_fg = 1 THEN 1045 END
LEFT JOIN DBP_DATA.art_2 z21
  ON a.mandant_id = z21.mandant_id AND
     a.art_id = z21.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z21.gga_fg = 1 THEN 1046 END
LEFT JOIN DBP_DATA.art_2 z22
  ON a.mandant_id = z22.mandant_id AND
     a.art_id = z22.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z22.oeko_tex_fg = 1 THEN 1047 END
LEFT JOIN DBP_DATA.art_2 z23
  ON a.mandant_id = z23.mandant_id AND
     a.art_id = z23.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z23.oeko_tex_std_100_plus_fg = 1 THEN 1048 END
LEFT JOIN DBP_DATA.art_2 z24
  ON a.mandant_id = z24.mandant_id AND
     a.art_id = z24.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z24.rainf_kaffee_fg = 1 THEN 1049 END
LEFT JOIN DBP_DATA.art_2 z25
  ON a.mandant_id = z25.mandant_id AND
     a.art_id = z25.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z25.rainf_kakao_fg = 1 THEN 1050 END
LEFT JOIN DBP_DATA.art_2 z26
  ON a.mandant_id = z26.mandant_id AND
     a.art_id = z26.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z26.vier_pfoten_fg = 1 THEN 1051 END
LEFT JOIN DBP_DATA.art_2 z27
  ON a.mandant_id = z27.mandant_id AND
     a.art_id = z27.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z27.weidehaltung_fg = 1 THEN 1052 END
LEFT JOIN DBP_DATA.art_2 z28
  ON a.mandant_id = z28.mandant_id AND
     a.art_id = z28.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z28.unsere_region_fg = 1 THEN 1053 END
LEFT JOIN DBP_DATA.art_2 z29
  ON a.mandant_id = z29.mandant_id AND
     a.art_id = z29.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z29.lets_bbq_fg = 1 THEN 1054 END   
LEFT JOIN DBP_DATA.art_2 z30
  ON a.mandant_id = z30.mandant_id AND
     a.art_id = z30.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z30.verpackungseinsparung_fg = 1 THEN 1055 END
LEFT JOIN DBP_DATA.art_2 z31
  ON a.mandant_id = z31.mandant_id AND
     a.art_id = z31.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z31.cz_norm_fg = 1 THEN 1056 END
LEFT JOIN DBP_DATA.art_2 z32
  ON a.mandant_id = z32.mandant_id AND
     a.art_id = z32.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z32.kl_exclusiv_fg = 1 THEN 1057 END
LEFT JOIN DBP_DATA.art_2 z33
  ON a.mandant_id = z33.mandant_id AND
     a.art_id = z33.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z33.zum_fasten_fg = 1 THEN 1058 END
LEFT JOIN DBP_DATA.art_2 z34
  ON a.mandant_id = z34.mandant_id AND
     a.art_id = z34.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z34.kl_besonderes_fg = 1 THEN 1059 END
LEFT JOIN DBP_DATA.art_2 z35
  ON a.mandant_id = z35.mandant_id AND
     a.art_id = z35.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z35.stahlhaltung_fg = 1 THEN 1060 END
LEFT JOIN DBP_DATA.art_2 z36
  ON a.mandant_id = z36.mandant_id AND
     a.art_id = z36.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z36.stahlhaltung_plus_fg = 1 THEN 1061 END
LEFT JOIN DBP_DATA.art_2 z37
  ON a.mandant_id = z37.mandant_id AND
     a.art_id = z37.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z37.aussenklima_haltung_fg = 1 THEN 1062 END
LEFT JOIN DBP_DATA.art_2 z38
  ON a.mandant_id = z38.mandant_id AND
     a.art_id = z38.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z38.premium_haltung_fg = 1 THEN 1063 END
LEFT JOIN DBP_DATA.art_2 z39
  ON a.mandant_id = z39.mandant_id AND
     a.art_id = z39.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z39.machen_macht_unterschied_fg = 1 THEN 1064 END
LEFT JOIN DBP_DATA.art_2 z40
  ON a.mandant_id = z40.mandant_id AND
     a.art_id = z40.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z40.premium_fg = 1 THEN 1065 END
LEFT JOIN DBP_DATA.art_2 z41
  ON a.mandant_id = z41.mandant_id AND
     a.art_id = z41.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z41.qafp_fg = 1 THEN 1066 END
LEFT JOIN DBP_DATA.art_2 z42
  ON a.mandant_id = z42.mandant_id AND
     a.art_id = z42.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z42.qudal_fg = 1 THEN 1067 END
LEFT JOIN DBP_DATA.art_2 z43
  ON a.mandant_id = z43.mandant_id AND
     a.art_id = z43.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z43.regionale_lebensmittel_fg = 1 THEN 1068 END
LEFT JOIN DBP_DATA.art_2 z44
  ON a.mandant_id = z44.mandant_id AND
     a.art_id = z44.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z44.startup_fg = 1 THEN 1069 END
LEFT JOIN DBP_DATA.art_2 z45
  ON a.mandant_id = z45.mandant_id AND
     a.art_id = z45.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z45.togo_fg = 1 THEN 1070 END
LEFT JOIN DBP_DATA.art_2 z46
  ON a.mandant_id = z46.mandant_id AND
     a.art_id = z46.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z46.ohne_microplastik_fg = 1 THEN 1071 END
LEFT JOIN DBP_DATA.art_2 z47
  ON a.mandant_id = z47.mandant_id AND
     a.art_id = z47.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z47.grk_fg = 1 THEN 1072 END
LEFT JOIN DBP_DATA.art_2 z48
  ON a.mandant_id = z48.mandant_id AND
     a.art_id = z48.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z48.ppl_fg = 1 THEN 1073 END
--LEFT JOIN DBP_DATA.art_2 z49
  --ON a.mandant_id = z49.mandant_id AND
    -- a.art_id = z49.art_id AND
    -- a.nachhaltigkeitslogo_id = CASE WHEN z49.bev_fg = 1 THEN 1074 END
LEFT JOIN DBP_DATA.art_2 z50
  ON a.mandant_id = z50.mandant_id AND
     a.art_id = z50.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z50.rpp_fg = 1 THEN 1075 END
LEFT JOIN DBP_DATA.art_2 z51
  ON a.mandant_id = z51.mandant_id AND
     a.art_id = z51.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z51.rsc_fg = 1 THEN 1076 END
LEFT JOIN DBP_DATA.art_2 z52
  ON a.mandant_id = z52.mandant_id AND
     a.art_id = z52.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z52.wsi_fg = 1 THEN 1077 END
LEFT JOIN DBP_DATA.art_2 z53
  ON a.mandant_id = z53.mandant_id AND
     a.art_id = z53.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z53.vbe_fg = 1 THEN 1078 END	 
LEFT JOIN DBP_DATA.art_2 z54
  ON a.mandant_id = z54.mandant_id AND
     a.art_id = z54.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z54.fte_fg = 1 THEN 1079 END	 
LEFT JOIN DBP_DATA.art_2 z55
  ON a.mandant_id = z55.mandant_id AND
     a.art_id = z55.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z55.kni_fg = 1 THEN 1080 END	 
LEFT JOIN DBP_DATA.art_2 z56
  ON a.mandant_id = z56.mandant_id AND
     a.art_id = z56.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z56.nhi_fg = 1 THEN 1081 END	 
LEFT JOIN DBP_DATA.art_2 z57
  ON a.mandant_id = z57.mandant_id AND
     a.art_id = z57.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z57.vac_fg = 1 THEN 1082 END	 
LEFT JOIN DBP_DATA.art_2 z58
  ON a.mandant_id = z58.mandant_id AND
     a.art_id = z58.art_id AND
     a.nachhaltigkeitslogo_id = CASE WHEN z58.gbs_fg = 1 THEN 1083 END	
LEFT JOIN DBP_DATA.art_2 z59
  ON a.mandant_id = z59.mandant_id      AND
     a.art_id     = z59.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z59.ggn_fg = 1 THEN 1084 END 
LEFT JOIN DBP_DATA.art_2 z60
  ON a.mandant_id = z60.mandant_id      AND
     a.art_id     = z60.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z60.bap_fg = 1 THEN 1085 END 
LEFT JOIN DBP_DATA.art_2 z61
  ON a.mandant_id = z61.mandant_id      AND
     a.art_id     = z61.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z61.okt_fg = 1 THEN 1086 END 
LEFT JOIN DBP_DATA.art_2 z62
  ON a.mandant_id = z62.mandant_id      AND
     a.art_id     = z62.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z62.daa_fg = 1 THEN 1087 END
--LEFT JOIN DBP_DATA.art_2 z63
--  ON a.mandant_id = z63.mandant_id      AND
--     a.art_id     = z63.art_id          AND
--     a.nachhaltigkeitslogo_id = CASE WHEN z63.nmw_fg = 1 THEN 1088 END 
LEFT JOIN DBP_DATA.art_2 z64
  ON a.mandant_id = z64.mandant_id      AND
     a.art_id     = z64.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z64.dachlogo_fg = 1 THEN 1089 END 
--LEFT JOIN DBP_DATA.art_2 z65
--  ON a.mandant_id = z65.mandant_id      AND
--     a.art_id     = z65.art_id          AND
--     a.nachhaltigkeitslogo_id = CASE WHEN z65.bum_fg = 1 THEN 1090 END 
--LEFT JOIN DBP_DATA.art_2 z66
--  ON a.mandant_id = z66.mandant_id      AND
--     a.art_id     = z66.art_id          AND
--     a.nachhaltigkeitslogo_id = CASE WHEN z66.fim_fg = 1 THEN 1091 END 
--LEFT JOIN DBP_DATA.art_2 z67
--  ON a.mandant_id = z67.mandant_id      AND
--     a.art_id     = z67.art_id          AND
--     a.nachhaltigkeitslogo_id = CASE WHEN z67.gab_fg = 1 THEN 1092 END 
LEFT JOIN DBP_DATA.art_2 z68
  ON a.mandant_id = z68.mandant_id      AND
     a.art_id     = z68.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z68.nat_bio_siegel_fg = 1 THEN 1093 END 
LEFT JOIN DBP_DATA.art_2 z69
  ON a.mandant_id = z69.mandant_id      AND
     a.art_id     = z69.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z69.fair_sugar_prog_fg = 1 THEN 1094 END 
LEFT JOIN DBP_DATA.art_2 z70
  ON a.mandant_id = z70.mandant_id      AND
     a.art_id     = z70.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z70.fair_cotton_prog_fg = 1 THEN 1095 END 
LEFT JOIN DBP_DATA.art_2 z71
  ON a.mandant_id = z71.mandant_id      AND
     a.art_id     = z71.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z71.sustainable_cleaning_fg = 1 THEN 1096 END
LEFT JOIN DBP_DATA.art_2 z72
  ON a.mandant_id = z72.mandant_id      AND
     a.art_id     = z72.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z72.rainforest_alliance_tee_fg = 1 THEN 1097 END
LEFT JOIN DBP_DATA.art_2 z73
  ON a.mandant_id = z73.mandant_id      AND
     a.art_id     = z73.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z73.heumilch_fg = 1 THEN 1098 END
LEFT JOIN DBP_DATA.art_2 z74
  ON a.mandant_id = z74.mandant_id      AND
     a.art_id     = z74.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z74.fairmast_fg = 1 THEN 1099 END
LEFT JOIN DBP_DATA.art_2 z75
  ON a.mandant_id = z75.mandant_id      AND
     a.art_id     = z75.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z75.kat_kontrolliert_fg = 1 THEN 1100 END
LEFT JOIN DBP_DATA.art_2 z76
  ON a.mandant_id = z76.mandant_id      AND
     a.art_id     = z76.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z76.kdk_kalb_fg = 1 THEN 1101 END
LEFT JOIN DBP_DATA.art_2 z77
  ON a.mandant_id = z77.mandant_id      AND
     a.art_id     = z77.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z77.organic_cont_std_fg = 1 THEN 1102 END
LEFT JOIN DBP_DATA.art_2 z78
  ON a.mandant_id = z78.mandant_id      AND
     a.art_id     = z78.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z78.global_rec_std_fg = 1 THEN 1103 END
LEFT JOIN DBP_DATA.art_2 z79
  ON a.mandant_id = z79.mandant_id      AND
     a.art_id     = z79.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z79.global_rec_std_50_fg = 1 THEN 1104 END
LEFT JOIN DBP_DATA.art_2 z80
  ON a.mandant_id = z80.mandant_id      AND
     a.art_id     = z80.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z80.global_rec_std_55_fg = 1 THEN 1105 END
LEFT JOIN DBP_DATA.art_2 z81
  ON a.mandant_id = z81.mandant_id      AND
     a.art_id     = z81.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z81.global_rec_std_60_fg = 1 THEN 1106 END
LEFT JOIN DBP_DATA.art_2 z82
  ON a.mandant_id = z82.mandant_id      AND
     a.art_id     = z82.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z82.global_rec_std_65_fg = 1 THEN 1107 END
LEFT JOIN DBP_DATA.art_2 z83
  ON a.mandant_id = z83.mandant_id      AND
     a.art_id     = z83.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z83.global_rec_std_70_fg = 1 THEN 1108 END
LEFT JOIN DBP_DATA.art_2 z84
  ON a.mandant_id = z84.mandant_id      AND
     a.art_id     = z84.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z84.global_rec_std_75_fg = 1 THEN 1109 END
LEFT JOIN DBP_DATA.art_2 z85
  ON a.mandant_id = z85.mandant_id      AND
     a.art_id     = z85.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z85.global_rec_std_80_fg = 1 THEN 1110 END
LEFT JOIN DBP_DATA.art_2 z86
  ON a.mandant_id = z86.mandant_id      AND
     a.art_id     = z86.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z86.global_rec_std_85_fg = 1 THEN 1111 END
LEFT JOIN DBP_DATA.art_2 z87
  ON a.mandant_id = z87.mandant_id      AND
     a.art_id     = z87.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z87.global_rec_std_90_fg = 1 THEN 1112 END
LEFT JOIN DBP_DATA.art_2 z88
  ON a.mandant_id = z88.mandant_id      AND
     a.art_id     = z88.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z88.institut_heidger_fg = 1 THEN 1113 END
LEFT JOIN DBP_DATA.art_2 z89
  ON a.mandant_id = z89.mandant_id      AND
     a.art_id     = z89.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z89.cotton_mia_fg = 1 THEN 1114 END
LEFT JOIN DBP_DATA.art_2 z90
  ON a.mandant_id = z90.mandant_id      AND
     a.art_id     = z90.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z90.downpass_fg = 1 THEN 1115 END
LEFT JOIN DBP_DATA.art_2 z91
  ON a.mandant_id = z91.mandant_id      AND
     a.art_id     = z91.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z91.junghahnaufzucht_fg = 1 THEN 1116 END
LEFT JOIN DBP_DATA.art_2 z92
  ON a.mandant_id = z92.mandant_id      AND
     a.art_id     = z92.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z92.bord_bia_fg = 1 THEN 1117 END
LEFT JOIN DBP_DATA.art_2 z93
  ON a.mandant_id = z93.mandant_id      AND
     a.art_id     = z93.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z93.gss_fg = 1 THEN 1118 END
LEFT JOIN DBP_DATA.art_2 z94
  ON a.mandant_id = z94.mandant_id      AND
     a.art_id     = z94.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z94.tuv_fg = 1 THEN 1119 END
LEFT JOIN DBP_DATA.art_2 z95
  ON a.mandant_id = z95.mandant_id      AND
     a.art_id     = z95.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z95.ces_fg = 1 THEN 1120 END
LEFT JOIN DBP_DATA.art_2 z97
  ON a.mandant_id = z97.mandant_id      AND
     a.art_id     = z97.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z97.aklasa_fg = 1 THEN 1121 END
LEFT JOIN DBP_DATA.art_2 z99
  ON a.mandant_id = z99.mandant_id      AND
     a.art_id     = z99.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z99.i_know_fg = 1 THEN 1122 END
LEFT JOIN DBP_DATA.art_2 z100
  ON a.mandant_id = z100.mandant_id      AND
     a.art_id     = z100.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z100.czech_guild_std_fg = 1 THEN 1123 END
LEFT JOIN DBP_DATA.art_2 z101
  ON a.mandant_id = z101.mandant_id      AND
     a.art_id     = z101.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z101.czech_food_fg = 1 THEN 1124 END
LEFT JOIN DBP_DATA.art_2 z102
  ON a.mandant_id = z102.mandant_id      AND
     a.art_id     = z102.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z102.organic_cotton_fg = 1 THEN 1125 END
LEFT JOIN DBP_DATA.art_2 z103
  ON a.mandant_id = z103.mandant_id      AND
     a.art_id     = z103.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z103.sephora_fg = 1 THEN 1126 END
LEFT JOIN DBP_DATA.art_2 z104
  ON a.mandant_id = z104.mandant_id      AND
     a.art_id     = z104.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z104.green_globe_fg = 1 THEN 1127 END
LEFT JOIN DBP_DATA.art_2 z105
  ON a.mandant_id = z105.mandant_id      AND
     a.art_id     = z105.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z105.certificare_fg = 1 THEN 1128 END
LEFT JOIN DBP_DATA.art_2 z106
  ON a.mandant_id = z106.mandant_id      AND
     a.art_id     = z106.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z106.bg_state_std_fg = 1 THEN 1129 END
LEFT JOIN DBP_DATA.art_2 z107
  ON a.mandant_id = z107.mandant_id      AND
     a.art_id     = z107.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z107.ayvar_quality_fg = 1 THEN 1130 END
LEFT JOIN DBP_DATA.art_2 z108
  ON a.mandant_id = z108.mandant_id      AND
     a.art_id     = z108.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z108.creekstone_farm_fg = 1 THEN 1131 END
LEFT JOIN DBP_DATA.art_2 z109
  ON a.mandant_id = z109.mandant_id      AND
     a.art_id     = z109.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z109.milchprodukte_fg = 1 THEN 1132 END
LEFT JOIN DBP_DATA.art_2 z110
  ON a.mandant_id = z110.mandant_id      AND
     a.art_id     = z110.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z110.stara_planina_fg = 1 THEN 1133 END
LEFT JOIN DBP_DATA.art_2 z111
  ON a.mandant_id = z111.mandant_id      AND
     a.art_id     = z111.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z111.bgi_fg = 1 THEN 1134 END
LEFT JOIN DBP_DATA.art_2 z112
  ON a.mandant_id = z112.mandant_id      AND
     a.art_id     = z112.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z112.bgs_fg = 1 THEN 1135 END
LEFT JOIN DBP_DATA.art_2 z113
  ON a.mandant_id = z113.mandant_id      AND
     a.art_id     = z113.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z113.brot_qual_fg = 1 THEN 1136 END
LEFT JOIN DBP_DATA.art_2 z114
  ON a.mandant_id = z114.mandant_id      AND
     a.art_id     = z114.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z114.dti_fg = 1 THEN 1137 END
LEFT JOIN DBP_DATA.art_2 z115
  ON a.mandant_id = z115.mandant_id      AND
     a.art_id     = z115.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z115.mfd_fg = 1 THEN 1138 END
LEFT JOIN DBP_DATA.art_2 z116
  ON a.mandant_id = z116.mandant_id      AND
     a.art_id     = z116.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z116.consumer_choice_fg = 1 THEN 1139 END
LEFT JOIN DBP_DATA.art_2 z117
  ON a.mandant_id = z117.mandant_id      AND
     a.art_id     = z117.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z117.flash_fg = 1 THEN 1140 END
LEFT JOIN DBP_DATA.art_2 z118
  ON a.mandant_id = z118.mandant_id      AND
     a.art_id     = z118.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z118.cz_appetizer_fg = 1 THEN 1141 END
LEFT JOIN DBP_DATA.art_2 z119
  ON a.mandant_id = z119.mandant_id      AND
     a.art_id     = z119.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z119.children_appetizer_fg = 1 THEN 1142 END
LEFT JOIN DBP_DATA.art_2 z120
  ON a.mandant_id = z120.mandant_id      AND
     a.art_id     = z120.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z120.natulon_fg = 1 THEN 1143 END
LEFT JOIN DBP_DATA.art_2 z121
  ON a.mandant_id = z121.mandant_id      AND
     a.art_id     = z121.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z121.laenderherz_5d_fg = 1 THEN 1144 END
LEFT JOIN DBP_DATA.art_2 z122
  ON a.mandant_id = z122.mandant_id      AND
     a.art_id     = z122.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z122.ohne_gentechnik_nicht_vlog_fg = 1 THEN 1145 END
LEFT JOIN DBP_DATA.art_2 z1148
  ON a.mandant_id = z1148.mandant_id      AND
     a.art_id     = z1148.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1148.traditional_certified_product_fg = 1 THEN 1148 END  
LEFT JOIN DBP_DATA.art_2 z1149
  ON a.mandant_id = z1149.mandant_id      AND
     a.art_id     = z1149.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1149.herkunftskennzeichen_de_fg = 1 THEN 1149 END 
LEFT JOIN DBP_DATA.art_2 z1150
  ON a.mandant_id = z1150.mandant_id      AND
     a.art_id     = z1150.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1150.leather_working_group_fg = 1 THEN 1150 END 
LEFT JOIN DBP_DATA.art_2 z1151
  ON a.mandant_id = z1151.mandant_id      AND
     a.art_id     = z1151.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1151.silphie_fg = 1 THEN 1151 END 
LEFT JOIN DBP_DATA.art_2 z1152
  ON a.mandant_id = z1152.mandant_id      AND
     a.art_id     = z1152.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1152.rainforest_banane_fg = 1 THEN 1152 END 
LEFT JOIN DBP_DATA.art_2 z1153
  ON a.mandant_id = z1153.mandant_id      AND
     a.art_id     = z1153.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1153.rainforest_schwarztee_fg = 1 THEN 1153 END 
LEFT JOIN DBP_DATA.art_2 z1154
  ON a.mandant_id = z1154.mandant_id      AND
     a.art_id     = z1154.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1154.rainforest_orange_fg = 1 THEN 1154 END 
LEFT JOIN DBP_DATA.art_2 z1155
  ON a.mandant_id = z1155.mandant_id      AND
     a.art_id     = z1155.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1155.vlabel_fg = 1 THEN 1155 END 
LEFT JOIN DBP_DATA.art_2 z1156
  ON a.mandant_id = z1156.mandant_id      AND
     a.art_id     = z1156.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1156.qmilch_plus_fg = 1 THEN 1156 END 
LEFT JOIN DBP_DATA.art_2 z1157
  ON a.mandant_id = z1157.mandant_id      AND
     a.art_id     = z1157.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1157.global_rec_std_filling_fg = 1 THEN 1157 END 
LEFT JOIN DBP_DATA.art_2 z1158
  ON a.mandant_id = z1158.mandant_id      AND
     a.art_id     = z1158.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1158.organic_con_std_blended_fg = 1 THEN 1158 END 
LEFT JOIN DBP_DATA.art_2 z1159
  ON a.mandant_id = z1159.mandant_id      AND
     a.art_id     = z1159.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1159.gots_made_with_organic_fg = 1 THEN 1159 END 
LEFT JOIN DBP_DATA.art_2 z1160
  ON a.mandant_id = z1160.mandant_id      AND
     a.art_id     = z1160.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1160.rcs_fg = 1 THEN 1160 END 
LEFT JOIN DBP_DATA.art_2 z1161
  ON a.mandant_id = z1161.mandant_id      AND
     a.art_id     = z1161.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1161.rcs_blended_fg = 1 THEN 1161 END 
LEFT JOIN DBP_DATA.art_2 z1162
  ON a.mandant_id = z1162.mandant_id      AND
     a.art_id     = z1162.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1162.rcs_filling_fg = 1 THEN 1162 END 
LEFT JOIN DBP_DATA.art_2 z1163
  ON a.mandant_id = z1163.mandant_id      AND
     a.art_id     = z1163.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1163.rcs_filling_blended_fg = 1 THEN 1163 END 
LEFT JOIN DBP_DATA.art_2 z1164
  ON a.mandant_id = z1164.mandant_id      AND
     a.art_id     = z1164.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1164.made_in_germany_fg = 1 THEN 1164 END 
LEFT JOIN DBP_DATA.art_2 z1165
  ON a.mandant_id = z1165.mandant_id      AND
     a.art_id     = z1165.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1165.cyclos_fg = 1 THEN 1165 END 
LEFT JOIN DBP_DATA.art_2 z1166
  ON a.mandant_id = z1166.mandant_id      AND
     a.art_id     = z1166.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1166.rainforest_haselnuss_fg = 1 THEN 1166 END 
LEFT JOIN DBP_DATA.art_2 z1167
  ON a.mandant_id = z1167.mandant_id      AND
     a.art_id     = z1167.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1167.rmc_blue_fg = 1 THEN 1167 END 
LEFT JOIN DBP_DATA.art_2 z1168
  ON a.mandant_id = z1168.mandant_id      AND
     a.art_id     = z1168.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1168.rws_fg = 1 THEN 1168 END 
LEFT JOIN DBP_DATA.art_2 z1169
  ON a.mandant_id = z1169.mandant_id      AND
     a.art_id     = z1169.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1169.bio_haltung_fg = 1 THEN 1169 END 
LEFT JOIN DBP_DATA.art_2 z1170
  ON a.mandant_id = z1170.mandant_id      AND
     a.art_id     = z1170.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1170.vegan_kaufland_fg = 1 THEN 1170 END 
LEFT JOIN DBP_DATA.art_2 z1171
  ON a.mandant_id = z1171.mandant_id      AND
     a.art_id     = z1171.art_id          AND
     a.nachhaltigkeitslogo_id = CASE WHEN z1171.sustainable_rice_platform_fg = 1 THEN 1171 END
 
WHERE (b.kl_art_id   IS NOT NULL  OR
       c.kl_art_id   IS NOT NULL  OR
       d.kl_art_id   IS NOT NULL  OR
       e.kl_art_id   IS NOT NULL  OR
       f.kl_art_id   IS NOT NULL  OR
       g.kl_art_id   IS NOT NULL  OR
       h.kl_art_id   IS NOT NULL  OR
       i.kl_art_id   IS NOT NULL  OR
       j.kl_art_id   IS NOT NULL  OR
       k.kl_art_id   IS NOT NULL  OR
       l.kl_art_id   IS NOT NULL  OR
       m.kl_art_id   IS NOT NULL  OR
       n.kl_art_id   IS NOT NULL  OR
       o.kl_art_id   IS NOT NULL  OR
       p.kl_art_id   IS NOT NULL  OR
       q.kl_art_id   IS NOT NULL  OR
       r.kl_art_id   IS NOT NULL  OR
       s.kl_art_id   IS NOT NULL  OR
       t.kl_art_id   IS NOT NULL  OR
       u.kl_art_id   IS NOT NULL  OR
       v.kl_art_id   IS NOT NULL  OR
       w.kl_art_id   IS NOT NULL  OR
       x.kl_art_id   IS NOT NULL  OR
       y.kl_art_id   IS NOT NULL  OR
       z.kl_art_id   IS NOT NULL  OR
       z1.kl_art_id  IS NOT NULL  OR
       z2.kl_art_id  IS NOT NULL  OR
       z3.kl_art_id  IS NOT NULL  OR
       z4.kl_art_id  IS NOT NULL  OR
       z5.kl_art_id  IS NOT NULL  OR
       z6.kl_art_id  IS NOT NULL  OR
       z7.kl_art_id  IS NOT NULL  OR
       z8.kl_art_id  IS NOT NULL  OR
       z9.kl_art_id  IS NOT NULL  OR
       z10.kl_art_id IS NOT NULL  OR
       z11.kl_art_id IS NOT NULL  OR
       z12.kl_art_id IS NOT NULL  OR
       z13.kl_art_id IS NOT NULL  OR
       z14.kl_art_id IS NOT NULL  OR
       z15.kl_art_id IS NOT NULL  OR
       z16.kl_art_id IS NOT NULL  OR
       z17.kl_art_id IS NOT NULL  OR
       z18.kl_art_id IS NOT NULL  OR
       z19.kl_art_id IS NOT NULL  OR
       z20.kl_art_id IS NOT NULL  OR
       z21.kl_art_id IS NOT NULL  OR
       z22.kl_art_id IS NOT NULL  OR
       z23.kl_art_id IS NOT NULL  OR
       z24.kl_art_id IS NOT NULL  OR
       z25.kl_art_id IS NOT NULL  OR
       z26.kl_art_id IS NOT NULL  OR
       z27.kl_art_id IS NOT NULL  OR
       z28.kl_art_id IS NOT NULL  OR
       z29.kl_art_id IS NOT NULL  OR
       z30.kl_art_id IS NOT NULL  OR
       z31.kl_art_id IS NOT NULL  OR
       z32.kl_art_id IS NOT NULL  OR
       z33.kl_art_id IS NOT NULL  OR
       z34.kl_art_id IS NOT NULL  OR
       z35.kl_art_id IS NOT NULL  OR
       z36.kl_art_id IS NOT NULL  OR
       z37.kl_art_id IS NOT NULL  OR
       z38.kl_art_id IS NOT NULL  OR
       z39.kl_art_id IS NOT NULL  OR
       z40.kl_art_id IS NOT NULL  OR
       z41.kl_art_id IS NOT NULL  OR
       z42.kl_art_id IS NOT NULL  OR
       z43.kl_art_id IS NOT NULL  OR
       z44.kl_art_id IS NOT NULL  OR
       z45.kl_art_id IS NOT NULL  OR
       z46.kl_art_id IS NOT NULL  OR
       z47.kl_art_id IS NOT NULL  OR
       z48.kl_art_id IS NOT NULL  OR
      -- z49.kl_art_id IS NOT NULL  OR
       z50.kl_art_id IS NOT NULL  OR
       z51.kl_art_id IS NOT NULL  OR
       z52.kl_art_id IS NOT NULL  OR
       z53.kl_art_id IS NOT NULL  OR
       z54.kl_art_id IS NOT NULL  OR
       z55.kl_art_id IS NOT NULL  OR
       z56.kl_art_id IS NOT NULL  OR
       z57.kl_art_id IS NOT NULL  OR
       z58.kl_art_id IS NOT NULL  OR
       z59.kl_art_id IS NOT NULL  OR
       z60.kl_art_id IS NOT NULL  OR
       z61.kl_art_id IS NOT NULL  OR
       z62.kl_art_id IS NOT NULL  OR
       --z63.kl_art_id IS NOT NULL  OR
       z64.kl_art_id IS NOT NULL  OR
       --z65.kl_art_id IS NOT NULL  OR
       --z66.kl_art_id IS NOT NULL  OR
       --z67.kl_art_id IS NOT NULL  OR
       z68.kl_art_id IS NOT NULL  OR
       z69.kl_art_id IS NOT NULL  OR
       z70.kl_art_id IS NOT NULL  OR
       z71.kl_art_id IS NOT NULL  OR
       z72.kl_art_id IS NOT NULL  OR
       z73.kl_art_id IS NOT NULL  OR
       z74.kl_art_id IS NOT NULL  OR
       z75.kl_art_id IS NOT NULL  OR
       z76.kl_art_id IS NOT NULL  OR
       z77.kl_art_id IS NOT NULL  OR
       z78.kl_art_id IS NOT NULL  OR
       z79.kl_art_id IS NOT NULL  OR
       z80.kl_art_id IS NOT NULL  OR
       z81.kl_art_id IS NOT NULL  OR
       z82.kl_art_id IS NOT NULL  OR
       z83.kl_art_id IS NOT NULL  OR
       z84.kl_art_id IS NOT NULL  OR
       z85.kl_art_id IS NOT NULL  OR
       z86.kl_art_id IS NOT NULL  OR
       z87.kl_art_id IS NOT NULL  OR
       z88.kl_art_id IS NOT NULL  OR
       z89.kl_art_id IS NOT NULL  OR
       z90.kl_art_id IS NOT NULL  OR
       z91.kl_art_id IS NOT NULL  OR
       z92.kl_art_id IS NOT NULL  OR
       z93.kl_art_id IS NOT NULL  OR
       z94.kl_art_id IS NOT NULL  OR
       z95.kl_art_id IS NOT NULL  OR
       --z96.kl_art_id IS NOT NULL  OR
       z97.kl_art_id IS NOT NULL  OR
       --z98.kl_art_id IS NOT NULL  OR
       z99.kl_art_id IS NOT NULL  OR
       z100.kl_art_id IS NOT NULL OR
       z101.kl_art_id IS NOT NULL OR
       z102.kl_art_id IS NOT NULL OR
       z103.kl_art_id IS NOT NULL OR
       z104.kl_art_id IS NOT NULL OR
       z105.kl_art_id IS NOT NULL OR
       z106.kl_art_id IS NOT NULL OR
       z107.kl_art_id IS NOT NULL OR
       z108.kl_art_id IS NOT NULL OR
       z109.kl_art_id IS NOT NULL OR
       z110.kl_art_id IS NOT NULL OR
       z111.kl_art_id IS NOT NULL OR
       z112.kl_art_id IS NOT NULL OR
       z113.kl_art_id IS NOT NULL OR
       z114.kl_art_id IS NOT NULL OR
       z115.kl_art_id IS NOT NULL OR
       z116.kl_art_id IS NOT NULL OR
       z117.kl_art_id IS NOT NULL OR
       z118.kl_art_id IS NOT NULL OR
       z119.kl_art_id IS NOT NULL OR
       z120.kl_art_id IS NOT NULL OR
       z121.kl_art_id IS NOT NULL OR
       z122.kl_art_id IS NOT NULL OR
       z1148.kl_art_id IS NOT NULL OR
       z1149.kl_art_id IS NOT NULL OR
       z1150.kl_art_id IS NOT NULL OR
       z1151.kl_art_id IS NOT NULL OR
       z1152.kl_art_id IS NOT NULL OR
       z1153.kl_art_id IS NOT NULL OR
       z1154.kl_art_id IS NOT NULL OR
       z1155.kl_art_id IS NOT NULL OR
       z1156.kl_art_id IS NOT NULL OR
       z1157.kl_art_id IS NOT NULL OR
       z1158.kl_art_id IS NOT NULL OR
       z1159.kl_art_id IS NOT NULL OR
       z1160.kl_art_id IS NOT NULL OR
       z1161.kl_art_id IS NOT NULL OR
       z1162.kl_art_id IS NOT NULL OR
       z1163.kl_art_id IS NOT NULL OR
       z1164.kl_art_id IS NOT NULL OR
       z1165.kl_art_id IS NOT NULL OR
       z1166.kl_art_id IS NOT NULL OR
       z1167.kl_art_id IS NOT NULL OR
       z1168.kl_art_id IS NOT NULL OR
       z1169.kl_art_id IS NOT NULL OR
       z1170.kl_art_id IS NOT NULL OR
       z1171.kl_art_id IS NOT NULL
)
);


DELETE FROM DBP_DATA.nachhaltigkeitslogo_art_zu_2
;

INSERT INTO DBP_DATA.nachhaltigkeitslogo_art_zu_2 
(mandant_id,
 art_id,
 nachhaltigkeitslogo_id,
 td_insert,
 td_update
)
SELECT 
 mandant_id,
 art_id,
 nachhaltigkeitslogo_id,
 CURRENT_TIMESTAMP,
 CURRENT_TIMESTAMP
FROM _step2
;
