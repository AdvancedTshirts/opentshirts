<?php
function showOptionRecursive($array, $selected, $level) {
	foreach($array as $option) {
		?>
		<option value="<?php echo $option['id_category'];?>" <?php if($option['id_category']==$selected) { echo 'selected="selected"'; } ?> >
			<?php for($i=0; $i<$level; $i++) { echo "&nbsp;---&nbsp;"; } ?>
			<?php echo $option['description']; ?>
		</option>
		<?php
		
		showOptionRecursive($option['children'], $selected, $level + 1);
	}
}
?>
<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/product.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><?php /*<a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a>*/ ?><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
		<div class="pagination"><?php echo $pagination; ?></div>
		<div style="padding:10px 0px; "><?php echo $text_limit; ?><input type="text" name="limit" class="ui-widget-content" value="<?php echo $limit; ?>" /></div>
        <table class="list">
          <thead>
			<tr>
			  <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
			  <td class="right"><?php echo $column_id_composition; ?></td>
			  <td class="left" width="90%"><?php if ($sort == 'c.name') { ?>
				<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
				<?php } else { ?>
				<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
				<?php } ?>
				  </td>
			  <td class="left">
			  <?php if ($sort == 'c.status') { ?>
				<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
				<?php } else { ?>
				<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
				<?php } ?>
			  </td>
			  <td class="left"><?php echo $column_categories; ?></td>
			  <td class="left"><?php echo $column_keywords; ?></td>
			  <td align="center"><?php echo $column_thumb; ?></td>
			  <td class="right" nowrap="nowrap"><?php if ($sort == 'c.date_added') { ?>
				<a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
				<?php } else { ?>
				<a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
				<?php } ?>
			  </td>
			  <td class="right"><?php echo $column_action; ?></td>
			</tr>
		  </thead>
		  <tbody>
			<tr class="filter">
			  <td></td>
			  <td class="right"><input type="text" name="filter_id_composition" class="ui-widget-content" value="<?php echo $filter_id_composition; ?>" size="4" style="text-align: right;" /></td>
			  <td></td>
			  <td class="left"><select name="filter_status" class="ui-widget-content" onchange="filter();">
			  <?php foreach ($statuses as $status) { ?>
				  <?php if ($status['val'] === $filter_status) { ?>
				  <option value="<?php echo $status['val']; ?>" selected="selected"><?php echo $status['description']; ?></option>
				  <?php } else { ?>
				  <option value="<?php echo $status['val']; ?>"><?php echo $status['description']; ?></option>
				  <?php } ?>
			  <?php } ?>
			</select></td>
			  <td><select name="filter_id_category" onchange="filter();" class="ui-widget-content">
			  <option value=""><?php echo $text_none; ?></option>
			  <?php showOptionRecursive($categories, $filter_id_category, 0); ?>
			</select></td>
			  <td><input type="text" name="filter_keyword" value="<?php echo $filter_keyword; ?>" class="ui-widget-content" /></td>
			  <td></td>
			  <td></td>
			  <td></td>
			</tr>
			<?php if ($compositions) { ?>
				<?php foreach ($compositions as $composition) { ?>
				<tr>
				  <td style="text-align: center;"><?php if ($composition['selected']) { ?>
				<input type="checkbox" name="selected[]" value="<?php echo $composition['id_composition']; ?>" checked="checked" />
				<?php } else { ?>
				<input type="checkbox" name="selected[]" value="<?php echo $composition['id_composition']; ?>" />
				<?php } ?></td>
				  <td width="20" class="right"><?php echo $composition['id_composition']; ?></td>
				  <td class="left"><a href="<?php echo $composition['link']; ?>" target="_blank"><?php echo $composition['name']; ?></a></td>
				  <td class="left"><?php echo $composition['status']; ?></td>
				  <td class="left"><ul><?php foreach ($composition['categories'] as $category) { ?>
				<li><?php echo $category['description']; ?></li>
				<?php } ?></ul></td>
				<td class="left"><ul><?php foreach ($composition['keywords'] as $keyword) { ?>
				<li><?php echo $keyword; ?></li>
				<?php } ?></ul></td>
				  <td align="center" valign="middle">
				  <a class="ui-widget-content" style="border-width: 0 0 1px 0; padding:3px; margin:1px; " id="a_<?php echo $composition['id_composition']; ?>" href="<?php echo $composition['images'][0]['original']; ?>" target="_new"><img border="0" id="img_<?php echo $composition['id_composition']; ?>" src="<?php echo $composition['images'][0]['large']; ?>" /></a>
				  <ul style="list-style:none; padding:0">
				  <?php foreach ($composition['images'] as $image) { ?>
					<li class="ui-widget-content" style="float:left; cursor:pointer; margin:2px;  " onclick="$('#img_<?php echo $composition['id_composition']; ?>').attr('src','<?php echo $image['large']; ?>'); $('#a_<?php echo $composition['id_composition']; ?>').attr('href','<?php echo $image['original']; ?>'); "><img src="<?php echo $image['thumb']; ?>" /></li>
					<?php } ?>
				  </ul>
				  </td>
				  <td class="right"><?php echo $composition['date_added']; ?></td>
				  <td class="right"><?php foreach ($composition['action'] as $action) { ?>
				[ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
				<?php } ?></td>
				</tr>
				<?php } ?>
			<?php } else { ?>
			<tr>
			  <td align="center" colspan="9"><?php echo $text_no_results; ?></td>
			</tr>
			<?php } ?>
		  </tbody>
		</table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=opentshirts/composition/_list&token=<?php echo $token; ?>';
	
	var filter_id_composition = $('input[name=\'filter_id_composition\']').attr('value');
	
	if (filter_id_composition) {
		url += '&filter_id_composition=' + encodeURIComponent(filter_id_composition);
	}
	
	var filter_status = $('select[name=\'filter_status\']').val();
	
	if (filter_status != '') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}
	
	var filter_id_category = $('select[name=\'filter_id_category\']').val();
	
	if (filter_id_category != '') {
		url += '&filter_id_category=' + encodeURIComponent(filter_id_category);
	}
	
	var filter_keyword = $('input[name=\'filter_keyword\']').val();
	
	if (filter_keyword) {
		url += '&filter_keyword=' + encodeURIComponent(filter_keyword);
	}
	
	var filter_date_added = $('input[name=\'filter_date_added\']').attr('value');
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}
	
	var limit = $('input[name=\'limit\']').attr('value');
	
	if (limit) {
		url += '&limit=' + encodeURIComponent(limit);
	}
				
	location = url;
}
//--></script>  
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script> 
<?php echo $footer; ?>