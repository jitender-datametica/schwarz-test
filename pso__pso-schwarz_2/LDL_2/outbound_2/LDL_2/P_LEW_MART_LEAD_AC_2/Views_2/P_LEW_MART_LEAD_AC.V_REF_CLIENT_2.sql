/* #----------------------------------------------------------------------------
# History:
#
# Vrs Date       Developer        Task
# --- ---------- --------------   ---------------------------------------
# 1.0 2018-03-28 Tris Bayliff     Initial version
#                                 20180328_1631_QuickView_BR_Client_View
# 1.1  10.08.2020 Roy,Ritanjal    Introduce new country_2 Latviya
# 1.2  04.02.2022 Michael Morris  Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_client_2 (int_id OPTIONS(description='Lidl International ID'),
client_id OPTIONS(description='Landeskennzeichen'), country_id OPTIONS(description='Country_2 ID'), client_desc_at
OPTIONS(description='Client description: AT'), client_desc_be OPTIONS(description='Client description: BE'),
client_desc_bg OPTIONS(description='Client description: BG'), client_desc_ch
OPTIONS(description='Client description: CH'), client_desc_cy OPTIONS(description='Client description: CY'),
client_desc_cz OPTIONS(description='Client description: CZ'), client_desc
OPTIONS(description='Client description: International'), client_desc_dk OPTIONS(description='Client description: DK'),
client_desc_ee OPTIONS(description='Client description: EE'), client_desc_es
OPTIONS(description='Client description: ES'), client_desc_fi OPTIONS(description='Client description: FI'),
client_desc_fr OPTIONS(description='Client description: FR'), client_desc_gb
OPTIONS(description='Client description: GB'), client_desc_gr OPTIONS(description='Client description: GR'),
client_desc_hr OPTIONS(description='Client description: HR'), client_desc_hu
OPTIONS(description='Client description: HU'), client_desc_ie OPTIONS(description='Client description: IE'),
client_desc_it OPTIONS(description='Client description: IT'), client_desc_lt
OPTIONS(description='Client description: LT'), client_desc_lv OPTIONS(description='Client description: LV'),
client_desc_ni OPTIONS(description='Client description: NI'), client_desc_nl
OPTIONS(description='Client description: NL'), client_desc_de OPTIONS(description='Client description: DE'),
client_desc_pl OPTIONS(description='Client description: PL'), client_desc_pt
OPTIONS(description='Client description: PT'), client_desc_ro OPTIONS(description='Client description: RO'),
client_desc_se OPTIONS(description='Client description: SE'), client_desc_si
OPTIONS(description='Client description: SI'), client_desc_sk OPTIONS(description='Client description: SK'),
client_desc_cs OPTIONS(description='Client description: CS'), client_desc_mt
OPTIONS(description='Client description: MT'), client_desc_us OPTIONS(description='Client description: US'),
client_desc_rs OPTIONS(description='Client description: RS_2'))
OPTIONS(DESCRIPTION = `LEAD PROJECT - CLIENT REFERENCE VIEW`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_client_2;