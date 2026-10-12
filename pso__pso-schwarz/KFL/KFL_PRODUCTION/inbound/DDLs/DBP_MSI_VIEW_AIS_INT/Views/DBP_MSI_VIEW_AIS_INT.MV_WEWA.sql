CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_wewa
(mandant_id
, wewa_beleg_id
, wewa_beleg_pos_id
, wewa_jahr
, art_id
, wup_id
, nb_id
, gp_id
, lager_bewart_id
, dat_buch
, menge_basis
, menge_basis_norm
, betrag_ekn
, betrag_vk_netto
, wewa_menge_zl
, wewa_menge_zl_norm
, wewa_menge_dz
, wewa_menge_dz_norm
, wewa_menge_ret_zl
, wewa_menge_ret_zl_norm
, wewa_menge_ret_dz
, wewa_menge_ret_dz_norm
, wewa_betrag_zl
, wewa_betrag_dz
, wewa_betrag_ret_zl
, wewa_betrag_ret_dz
, einstandspreis
, ek_mep_vor_fwu
, ek_mep
, ek_kalkulationsbasis
, ek_kalkulationsbasis_ohne_fwu
, ek_nettonetto
, Lief_EK_mep_Umsatz
, Lief_EK_mep_Umsatz_zl
, Lief_EK_mep_Umsatz_dz
, Lief_EK_mep_Umsatz_Ret
, Lief_EK_mep_Umsatz_Ret_dz
, Lief_EK_mep_Umsatz_Ret_zl
, Lief_EK_mep_vor_fwu_Umsatz
, Lief_EK_mep_vor_fwu_Umsatz_zl
, Lief_EK_mep_vor_fwu_Umsatz_dz
, Lief_EK_mep_vor_fwu_Umsatz_Ret
, Lief_EK_mep_vor_fwu_Umsatz_Ret_zl
, Lief_EK_mep_vor_fwu_Umsatz_Ret_dz
, logkosten
, wewa_status
, wrg_id
, posten_kz_per
)
--bauertob 20.07.2023 - AP0179744, SPEC0207782 - adjusted MEP-fields
--lsvi0303 02.11.2020 - AP0074875, SPEC0089162 - added ek_mep fields for mandant_id=1
--lsvi0303 21.02.2020 - AP0112499, SPEC0144895 - einstandspreis formatting
-- 21.11.2023 staeblern / Umbenennung der Spalte Betrag zu betrag_ek_netto
-- 08.03.2024 bauertob / Changed logic for Lief_EK_mep(_vor_fwu)_Umsatz to align KMO and DE
-- 18.07.2025 prescher / SPEC0313584- Aufnahme Fakt Kalkulationsbasis 
AS
SELECT
v01.mandant_id,
wewa_beleg_id,
wewa_beleg_pos_id,
wewa_jahr,
v01.art_id,
v01.wup_id,
v01.nb_id,
v01.gp_id,
v01.lager_bewart_id,
v01.dat_buch,
menge_basis,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  v01.menge_basis *  v05.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  v01.menge_basis *  v05.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_basis *  v05.inhalt_menge
WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  v01.menge_basis *  v05.inhalt_menge
-- länderübergreifend
WHEN v05.basismenge_einh_id = 'KG' THEN menge_basis
ELSE 0 END AS menge_basis_norm,

-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
CAST(CASE
WHEN   v200.wrg_typ_id  = 1 THEN v01.betrag_ek_netto
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  v01.betrag_ek_netto * v300.umrechnungskurs
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  v01.betrag_ek_netto * v400.umrechnungskurs 
END AS DECIMAL(18,6))   AS betrag_ekn,
CAST(CASE
WHEN v200.wrg_typ_id  = 1 THEN v01.betrag_vk_netto
WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  v01.betrag_vk_netto* v300.umrechnungskurs
WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  v01.betrag_vk_netto* v400.umrechnungskurs
END AS DECIMAL(18,6))   AS betrag_vk_netto,

CASE
WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = -111 THEN menge_basis
ELSE 0 END AS wewa_menge_zl,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  v01.menge_basis *  v05.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  v01.menge_basis *  v05.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_basis *  v05.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  v01.menge_basis *  v05.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'KG' THEN menge_basis
ELSE 0 END AS wewa_menge_zl_norm,

CASE
WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = 0 THEN menge_basis 
ELSE 0 END AS wewa_menge_dz,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  v01.menge_basis *  v05.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  v01.menge_basis *  v05.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_basis *  v05.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  v01.menge_basis *  v05.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (101, 102, 901, 902) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'KG' THEN menge_basis
ELSE 0 END AS wewa_menge_dz_norm,

CASE
WHEN lager_bewart_id IN (161, 162) AND nb_id = -111 THEN menge_basis
ELSE 0 END AS wewa_menge_ret_zl,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  v01.menge_basis *  v05.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  v01.menge_basis *  v05.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_basis *  v05.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  v01.menge_basis *  v05.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (161, 162) AND v01.nb_id = -111 AND v05.basismenge_einh_id = 'KG' THEN menge_basis
ELSE 0 END AS wewa_menge_ret_zl_norm,

CASE
WHEN lager_bewart_id IN (161, 162) AND nb_id = 0 THEN menge_basis
ELSE 0 END AS wewa_menge_ret_dz,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  v01.menge_basis *  v05.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  v01.menge_basis * (v05.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  v01.menge_basis *  v05.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_basis *  v05.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_basis * (v05.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  v01.menge_basis *  v05.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (161, 162) AND v01.nb_id = 0 AND v05.basismenge_einh_id = 'KG' THEN menge_basis
ELSE 0 END AS wewa_menge_ret_dz_norm,

CASE
WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = -111 THEN betrag_ekn END AS wewa_betrag_zl,
CASE
WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = 0 THEN betrag_ekn END AS wewa_betrag_dz,
CASE
WHEN lager_bewart_id IN (161, 162) AND nb_id = -111 THEN betrag_ekn END     AS wewa_betrag_ret_zl,
CASE
WHEN lager_bewart_id IN (161, 162) AND nb_id = 0 THEN betrag_ekn END     AS wewa_betrag_ret_dz,
CAST(CASE
WHEN   v200.wrg_typ_id  = 1 THEN COALESCE(v02.einstandspreis,v03.einstandspreis)
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(v02.einstandspreis,v03.einstandspreis)  * v300.umrechnungskurs
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(v02.einstandspreis,v03.einstandspreis)  * v400.umrechnungskurs
ELSE 0 END AS NUMBER(38,5))   AS einstandspreis_,
CAST(CASE
WHEN   v200.wrg_typ_id  = 1 THEN COALESCE(v02.ek_mep_vor_fwu,v03.ek_mep_vor_fwu)
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(v02.ek_mep_vor_fwu,v03.ek_mep_vor_fwu)  * v300.umrechnungskurs
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(v02.ek_mep_vor_fwu,v03.ek_mep_vor_fwu)  * v400.umrechnungskurs
ELSE 0 END AS NUMBER(38,5))   AS ek_mep_vor_fwu_,
CAST(CASE
WHEN   v200.wrg_typ_id  = 1 THEN COALESCE(v02.ek_mep,v03.ek_mep)
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(v02.ek_mep,v03.ek_mep)  * v300.umrechnungskurs
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(v02.ek_mep,v03.ek_mep)  * v400.umrechnungskurs
ELSE 0 END AS NUMBER(38,5))   AS ek_mep_,
CAST(CASE
WHEN   v200.wrg_typ_id  = 1 THEN COALESCE(v02.ek_kal_basis,v03.ek_kal_basis) * menge_basis
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  (COALESCE(v02.ek_kal_basis,v03.ek_kal_basis) * menge_basis)  * v300.umrechnungskurs
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  (COALESCE(v02.ek_kal_basis,v03.ek_kal_basis) * menge_basis)  * v400.umrechnungskurs
ELSE 0 END AS NUMBER(38,5))   AS ek_kalkulationsbasis,
CAST(CASE
WHEN   v200.wrg_typ_id = 1 THEN COALESCE(v02.ek_kal_basis,v03.ek_kal_basis)+(ek_mep_vor_fwu_-ek_mep_)
WHEN   v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN (COALESCE(v02.ek_kal_basis,v03.ek_kal_basis)* v300.umrechnungskurs) + (ek_mep_vor_fwu_-ek_mep_)
WHEN   v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN (COALESCE(v02.ek_kal_basis,v03.ek_kal_basis)* v400.umrechnungskurs) + (ek_mep_vor_fwu_-ek_mep_)
ELSE 0 END AS NUMBER(38,5))   AS ek_kalkulationsbasis_ohne_fwu,	 
CAST(CASE
WHEN   v200.wrg_typ_id  = 1 THEN COALESCE(v02.ek_nettonetto,v03.ek_nettonetto)
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(v02.ek_nettonetto,v03.ek_nettonetto)  * v300.umrechnungskurs 
WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(v02.ek_nettonetto,v03.ek_nettonetto)  * v400.umrechnungskurs 
END AS FLOAT)   AS ek_nettonetto,
--SPEC0207782
CAST((wewa_menge_zl+wewa_menge_dz)*ek_mep_ AS NUMBER(18,4)) AS Lief_EK_mep_Umsatz,
CAST(wewa_menge_zl*ek_mep_ AS NUMBER(18,4)) AS Lief_EK_mep_Umsatz_zl,
CAST(wewa_menge_dz*ek_mep_ AS NUMBER(18,4)) AS Lief_EK_mep_Umsatz_dz,
CAST((wewa_menge_ret_zl+wewa_menge_ret_dz)*ek_mep_ AS NUMBER(18,4)) AS Lief_EK_mep_Umsatz_Ret,
CAST(wewa_menge_ret_zl*ek_mep_ AS NUMBER(18,4)) AS Lief_EK_mep_Umsatz_Ret_zl,
CAST(wewa_menge_ret_dz*ek_mep_ AS NUMBER(18,4)) AS Lief_EK_mep_Umsatz_Ret_dz,
--SPEC0236778
CAST((wewa_menge_zl+wewa_menge_dz)*ek_mep_vor_fwu_ AS NUMBER(18,4)) AS Lief_EK_mep_vor_fwu_Umsatz,
CAST(wewa_menge_zl*ek_mep_vor_fwu_ AS NUMBER(18,4)) AS Lief_EK_mep_vor_fwu_Umsatz_zl,
CAST(wewa_menge_dz*ek_mep_vor_fwu_ AS NUMBER(18,4)) AS Lief_EK_mep_vor_fwu_Umsatz_dz,
CAST((wewa_menge_ret_zl+wewa_menge_ret_dz)*ek_mep_vor_fwu_ AS NUMBER(18,4)) AS Lief_EK_mep_vor_fwu_Umsatz_Ret,
CAST(wewa_menge_ret_zl*ek_mep_vor_fwu_ AS NUMBER(18,4)) AS Lief_EK_mep_vor_fwu_Umsatz_Ret_zl,
CAST(wewa_menge_ret_dz*ek_mep_vor_fwu_ AS NUMBER(18,4)) AS Lief_EK_mep_vor_fwu_Umsatz_Ret_dz,
CAST(0 AS NUMBER(18,4)) AS logkosten,
v01.status    AS wewa_status,
v01.wrg_id,
CASE
WHEN v04.POSTEN_ID NOT IN ('1') THEN 'SO'
ELSE 'PN'
END :: CHAR(2) AS posten_kz_per

FROM dbp_view.v_wewa v01

LEFT OUTER JOIN
             --ZEKP Auflösung, marktspezifische Preise
             (
SELECT
mandant_id,
art_id,
gp_id,
wup_id,
dat_von,
dat_bis,
einstandspreis,
ek_mep_vor_fwu,
ek_mep,
ek_kal_basis,
ek_nettonetto
FROM dbp_view.v_art_gp_wup_zu_per
            WHERE mandant_id > 1 AND wup_id > -1
            ) v02

            ON
            v01.mandant_id= v02.mandant_id AND
            v01.wup_id       = v02.wup_id        AND
            v01.gp_id          = v02.gp_id          AND
            v01.art_id          =  v02.art_id AND
            dat_buch BETWEEN v02.dat_von AND v02.dat_bis

LEFT OUTER JOIN
--ZEKP Auflösung allgemeingeltende Preise
(
SELECT
mandant_id,
art_id,
gp_id,
wup_id,
dat_von,
dat_bis,
einstandspreis,
ek_mep_vor_fwu,
ek_mep,
ek_kal_basis,
ek_nettonetto
FROM dbp_view.v_art_gp_wup_zu_per
            WHERE mandant_id > 1 AND wup_id = -1
            ) v03

            ON
            v01.mandant_id=  v03.mandant_id AND
            v01.gp_id          =  v03.gp_id          AND
            v01.art_id          =  v03.art_id AND
            dat_buch BETWEEN v03.dat_von AND v03.dat_bis

-- Ermittlung der eingestellter Währung
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

/*-- Umrechnung Standardkurs, Tageskurs              
JOIN
dbp_view.v_kurs v300
ON v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
AND v01.wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 9
AND v300.nach_wrg_id ='EUR'*/

-- JOIN aktueller Berichtskurs
JOIN dbp_view.v_kurs v300
ON v300.dat_bis = '9999-12-31'
AND v01.wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id ='EUR'

-- JOIN historischer Berichtskurs
JOIN dbp_view.v_kurs v400
ON v01.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
AND v01.wrg_id = v400.von_wrg_id
AND v400.kurstyp_id = 3
AND v400.nach_wrg_id ='EUR'

LEFT JOIN dbp_view.v_art_per v04
ON v01.art_id = v04.art_id
AND v01.mandant_id = v04.mandant_id
AND v01.dat_buch BETWEEN v04.dat_von-1 AND v04.dat_bis-1 

/* AP0219157/SPEC0256033 JOIN auf DBP_VIEW.V_ART wegen Erweiterung um Spalten norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
JOIN DBP_VIEW.V_ART v05
ON v01.mandant_id = v05.mandant_id
AND v01.art_id = v05.art_id

UNION ALL

SELECT
v01.mandant_id,
v01.bsch_id,
v01.bsch_pos_id,
TO_NUMBER(SUBSTR (v01.dat,1,4)) AS wewa_jahr,
v01.art_id,
v01.wup_id,
v01.nb_id,
v01.gp_id,
v01.lager_bewart_id,
v01.dat,
menge_rech, --CASE WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) THEN v01.menge_rech END AS Bsch_Menge

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'G'     THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'KG'    THEN  v01.menge_rech *  v03.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'ML'    THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'L'     THEN  v01.menge_rech *  v03.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'G'    THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_rech *  v03.inhalt_menge
WHEN v01.mandant_id > 1 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'L'    THEN  v01.menge_rech *  v03.inhalt_menge
-- länderübergreifend
WHEN v03.basismenge_einh_id = 'KG' THEN menge_rech
ELSE 0 END AS menge_rech_norm,

v01.ek_n,
v01.vk_n,
CASE
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' THEN v01.menge_rech END AS Bsch_Menge_zl,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'G'     THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'KG'    THEN  v01.menge_rech *  v03.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'ML'    THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'L'     THEN  v01.menge_rech *  v03.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'G'    THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_rech *  v03.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'L'    THEN  v01.menge_rech *  v03.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'KG' THEN menge_rech
ELSE 0 END AS Bsch_Menge_zl_norm,

CASE
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id IN (0) THEN v01.menge_rech END AS Bsch_Menge_dz,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'G'     THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'KG'    THEN  v01.menge_rech *  v03.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'ML'    THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'L'     THEN  v01.menge_rech *  v03.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'G'    THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_rech *  v03.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'L'    THEN  v01.menge_rech *  v03.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'KG' THEN menge_rech
ELSE 0 END AS Bsch_Menge_dz_norm,

CASE
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' THEN v01.menge_rech END AS Bsch_Menge_Ret_zl,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'G'     THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'KG'    THEN  v01.menge_rech *  v03.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'ML'    THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'L'     THEN  v01.menge_rech *  v03.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'G'    THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_rech *  v03.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'L'    THEN  v01.menge_rech *  v03.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' AND v03.basismenge_einh_id = 'KG' THEN menge_rech
ELSE 0 END AS Bsch_Menge_Ret_zl_norm,

CASE
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id IN (0) THEN v01.menge_rech END AS Bsch_Menge_Ret_dz,

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
CASE
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'G'     THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'KG'    THEN  v01.menge_rech *  v03.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'ML'    THEN  v01.menge_rech * (v03.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.einh_id = 'L'     THEN  v01.menge_rech *  v03.faktor_nettoinhalt
-- KMO
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'G'    THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'KG'   THEN  v01.menge_rech *  v03.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'ML'   THEN  v01.menge_rech * (v03.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'ST' AND v03.inhalt_menge_einh_id = 'L'    THEN  v01.menge_rech *  v03.inhalt_menge
-- länderübergreifend
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = 0 AND v03.basismenge_einh_id = 'KG' THEN menge_rech
ELSE 0 END AS Bsch_Menge_Ret_dz_norm,

CASE
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' THEN v01.ek_n END AS Lief_EK_n_Umsatz_zl,
CASE
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id IN (0) THEN v01.ek_n END AS Lief_EK_n_Umsatz_dz,
CASE
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' THEN v01.ek_n END AS Lief_EK_n_Umsatz_Ret_zl,
CASE
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id IN (0) THEN v01.ek_n END AS Lief_EK_n_Umsatz_Ret_dz,
v01.ek_mep,
CAST(0 AS NUMBER(38,5)),
v01.ek_mep,
v01.ek_kb,
CAST(0 AS NUMBER(38,5)),
v01.ek_nn,
CASE
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) THEN v01.ek_mep ELSE 0 END AS Lief_EK_mep_Umsatz,
CASE
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id = '-111' THEN v01.ek_mep ELSE 0 END AS Lief_EK_mep_Umsatz_zl,
CASE
WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) AND v01.nb_id IN (0) THEN v01.ek_mep ELSE 0 END AS Lief_EK_mep_Umsatz_dz,
CASE
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) THEN v01.ek_mep ELSE 0 END AS Lief_EK_mep_Umsatz_Ret,
CASE
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id = '-111' THEN v01.ek_mep ELSE 0 END AS Lief_EK_mep_Umsatz_Ret_zl,
CASE
WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) AND v01.nb_id IN (0) THEN v01.ek_mep ELSE 0 END AS Lief_EK_mep_Umsatz_Ret_dz,
--SPEC0236778
CAST(0 AS NUMBER(38,5)) AS Lief_EK_mep_vor_fwu_Umsatz,
CAST(0 AS NUMBER(38,5)) AS Lief_EK_mep_vor_fwu_Umsatz_zl,
CAST(0 AS NUMBER(38,5)) AS Lief_EK_mep_vor_fwu_Umsatz_dz,
CAST(0 AS NUMBER(38,5)) AS Lief_EK_mep_vor_fwu_Umsatz_Ret,
CAST(0 AS NUMBER(38,5)) AS Lief_EK_mep_vor_fwu_Umsatz_Ret_zl,
CAST(0 AS NUMBER(38,5)) AS Lief_EK_mep_vor_fwu_Umsatz_Ret_dz,
v01.logkosten,
v01.status,
'EUR' AS wrg_id,
CASE
    WHEN v2.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
    ELSE 'PN'
END :: CHAR(2) AS POSTEN_KZ_PER

FROM dbp_view.v_bsch_rech_det v01

LEFT JOIN dbp_view.v_art_per v2
ON v01.art_id = v2.art_id
AND v01.mandant_id = v2.mandant_id
AND v01.dat BETWEEN v2.dat_von-1 AND v2.dat_bis-1 

/* AP0219157/SPEC0256033 JOIN auf DBP_VIEW.V_ART wegen Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
JOIN DBP_VIEW.V_ART v03
ON v01.mandant_id = v03.mandant_id
AND v01.art_id = v03.art_id

WHERE v01.mandant_id = 1
AND v01.nb_id NOT IN (2,6,7)
AND v01.status <> 2;