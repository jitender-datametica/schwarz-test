CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_advert_media_group_hist_2
(
  client_id
, adv_media_grp_id
, adv_media_grp_de_name
, adv_media_grp_en_name
, display_seq
, lplus_fg
, file_name
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
SELECT
client_id,
adv_media_grp_id,
adv_media_grp_de_name,
adv_media_grp_en_name,
display_seq,
lplus_fg,
file_name,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_advert_media_group_hist_2 ;



