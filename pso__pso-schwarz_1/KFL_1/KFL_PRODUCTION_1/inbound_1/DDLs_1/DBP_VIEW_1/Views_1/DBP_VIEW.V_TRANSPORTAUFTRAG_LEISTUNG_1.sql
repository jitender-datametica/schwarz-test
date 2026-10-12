CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTAUFTRAG_LEISTUNG_1
AS SELECT
mandant_id,
transport_beleg_id,
transport_beleg_pos_id,
lagernummer_id,
wup_id,
nb_id,
transport_beleg_pos_sub_id,
leist_empfaenger_sap_id,
leist_empfaenger_gruppe_id,
ext_ma_fg,
ausschluss_fg,
art_id,
menge_ist_nach,
dat_leistung,
try_to_time(to_char(MOD(zeit_leistung,'240000'),'000000'),'HH24MISS') as zeit_leistung,
transport_gv_id,
versandblock_id,
von_lagertyp_id,
nach_lagertyp_id,
gp_id,
ressource_typ_id
FROM dbp_data.transportauftrag_leistung_1

;