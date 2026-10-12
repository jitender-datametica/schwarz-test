/* #----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country_1 LV
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  21.12.2021    Morris, Michael          Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_actiongroup_desc_1 (client_id OPTIONS(description='Landeskennzeichen'),
item_actiongroup_id
OPTIONS(description='Referenziert auf C665_MAINGRPNR, in der WAWI auf STRING 13, da zuerst geplant war, ACTIONGRP und AC'),
dat_valid_from OPTIONS(description='Gültig ab, wird vom Vorsystem Wawi geliefert'), dat_valid_until
OPTIONS(description='Gültig bis, wird vom Vorsystem Wawi geliefert'), item_actgroup_desc_at
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung AT'), item_actgroup_desc_be
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung BE'), item_actgroup_desc_be_fr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung BE_FR'), item_actgroup_desc_bg
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung BG'), item_actgroup_desc_ch
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CH'), item_actgroup_desc_cy
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CY'), item_actgroup_desc_cz
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CZ'), item_actgroup_desc
OPTIONS(description='Artikel_1 - Aktionsgruppe Beschreibung'), item_actgroup_desc_dk
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung DK'), item_actgroup_desc_ee
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung EE'), item_actgroup_desc_es
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung ES'), item_actgroup_desc_fi
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung FI'), item_actgroup_desc_fr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung FR'), item_actgroup_desc_gb
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung GB'), item_actgroup_desc_gr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung GR'), item_actgroup_desc_hr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung HR'), item_actgroup_desc_hu
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung HU'), item_actgroup_desc_ie
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung IE'), item_actgroup_desc_it
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung IT'), item_actgroup_desc_lt
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung LT'), item_actgroup_desc_lv
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung LV'), item_actgroup_desc_ni
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung NI'), item_actgroup_desc_nl
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung NL'), item_actgroup_desc_de
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung DE'), item_actgroup_desc_pl
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung PL'), item_actgroup_desc_pt
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung PT'), item_actgroup_desc_ro
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung RO'), item_actgroup_desc_se
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung SE'), item_actgroup_desc_si
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung SI'), item_actgroup_desc_sk
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung SK'), item_actgroup_desc_cs
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CS'), item_actgroup_desc_mt
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung MT'), item_actgroup_desc_us
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung US'), item_actgroup_desc_rs
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung RS_1'))
OPTIONS(DESCRIPTION = `Mulri language item_1 action group descriptions`) AS SELECT client_id,
 item_actiongroup_id,
 MIN(dat_valid_from) AS dat_valid_from,
 MAX(dat_valid_until) AS dat_valid_until,
 MAX(CASE
   WHEN language_id = 1
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_ee,
 MAX(CASE
   WHEN language_id = 10
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_hu,
 MAX(CASE
   WHEN language_id = 17
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN item_actgroup_desc
   ELSE NULL
   END) AS item_actgroup_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_itm_actiongroup_desc_1
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
GROUP BY client_id,
 item_actiongroup_id;