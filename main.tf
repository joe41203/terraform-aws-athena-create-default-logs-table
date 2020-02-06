data "template_file" "create_logs_table" {
  template = "${file("${path.module}/templates/${var.template_name}.sql.tpl")}"

  vars {
    table_name    = "${var.table_name}"
    target_bucket = "${var.target_bucket}"
    region        = "${var.region}"
    account_id    = "${var.account_id}"
    prefix        = "${var.prefix}"
  }
}

resource "aws_athena_named_query" "app_alb_access_logs" {
  name     = "create_${var.table_name}"
  database = "${var.database_name}"
  query    = "${data.template_file.create_logs_table.rendered}"
}
