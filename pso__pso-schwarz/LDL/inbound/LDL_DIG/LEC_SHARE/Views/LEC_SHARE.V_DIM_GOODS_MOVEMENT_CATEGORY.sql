CREATE OR REPLACE VIEW lec_share.v_dim_goods_movement_category
AS
SELECT
	*
FROM
	core.t_dim_goods_movement_category
;