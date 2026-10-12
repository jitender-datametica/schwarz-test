CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTAUFTRAG_2 
AS SELECT
     mandant_id
    ,transport_beleg_id
    ,lagernummer_id
    ,wup_id
    ,nb_id
    ,dat_erstellung
    ,try_to_time(TO_CHAR(MOD(zeit_erstellung,'240000'),'000000'),'HH24MISS') AS zeit_erstellung
    ,dat_quittierung
    ,transportart_id
    ,system_id
    ,lvs_bewart_id
    ,lief_beleg_id
    ,ta_prio
    ,dat_prio_upd
    ,try_to_time(TO_CHAR(MOD(zeit_prio_upd,'240000'),'000000'),'HH24MISS') AS zeit_prio_upd
    ,kj_lief_beleg
	,anz_pos_ta
	,datzeit_start_ta
	,datzeit_end_ta
	,referenznummer
	,dat_bereitstellung
	,datzeit_bereitstellung
	,wg_verkett_id
	,werbeware_id
	,lief_pal_typ_id
	,dat_lief_soll
	
FROM
    DBP_DATA.TRANSPORTAUFTRAG_2;