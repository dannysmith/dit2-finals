[1mdiff --git a/features/support/pages/course_request_page.rb b/features/support/pages/course_request_page.rb[m
[1mindex 66890b6..eb7670c 100644[m
[1m--- a/features/support/pages/course_request_page.rb[m
[1m+++ b/features/support/pages/course_request_page.rb[m
[36m@@ -6,10 +6,15 @@[m [mclass CourseRequestPage < GenericPage[m
   }[m
 [m
   ELEMENT = {[m
[31m-    fullname: { id: 'fitem_id_fullname' },[m
[31m-    shortname: { id: 'fitem_id_shortname' },[m
[31m-    reason: { id: 'fitem_id_reason' },[m
[31m-    error: { class: 'error' }[m
[32m+[m[32m    fullname: {id: 'fitem_id_fullname'},[m
[32m+[m[32m    shortname: {id: 'fitem_id_shortname'},[m
[32m+[m[32m    reason: {id: 'fitem_id_reason'},[m
[32m+[m[32m    error: {class: 'error'},[m
[32m+[m[32m    txt_fullname: {id: 'id_fullname'},[m
[32m+[m[32m    txt_shortname: {id: 'id_shortname'},[m
[32m+[m[32m    txt_summary: {id: 'id_summary_editoreditable'},[m
[32m+[m[32m    txt_reason: {id: 'id_reason'},[m
[32m+[m[32m    submit: {id: 'id_submitbutton'}[m
   }[m
 [m
   def visit[m
[36m@@ -25,28 +30,28 @@[m [mclass CourseRequestPage < GenericPage[m
   end[m
 [m
   def full_name=(full_name)[m
[31m-    @browser.text_field(id: 'id_fullname').set full_name[m
[32m+[m[32m    @browser.text_field(ELEMENT[:txt_fullname]).set full_name[m
   end[m
 [m
   def short_name=(short_name)[m
[31m-    @browser.text_field(id: 'id_shortname').set short_name[m
[32m+[m[32m    @browser.text_field(ELEMENT[:txt_shortname]).set short_name[m
   end[m
 [m
   def summary=(summary)[m
[31m-    @browser.element(id: 'id_summary_editoreditable').send_keys summary[m
[32m+[m[32m    @browser.element(ELEMENT[:txt_summary]).send_keys summary[m
   end[m
 [m
   def reason=(reason)[m
[31m-    @browser.textarea(id: 'id_reason').set reason[m
[32m+[m[32m    @browser.textarea(ELEMENT[:txt_reason]).set reason[m
   end[m
 [m
   def submit[m
[31m-    @browser.button(id: 'id_submitbutton').click[m
[32m+[m[32m    @browser.button(ELEMENT[:submit]).click[m
   end[m
 [m
[31m-  def error_displayed(key)[m
[31m-    raise "This element does not exist" unless @browser.div(ELEMENT[key]).span(ELEMENT[:error]).exists?[m
[31m-    @browser.div(ELEMENT[key]).span(ELEMENT[:error]).text[m
[32m+[m[32m  def error_displayed(item)[m
[32m+[m[32m    raise "This element does not exist" unless @browser.div(ELEMENT[item]).span(ELEMENT[:error]).exists?[m
[32m+[m[32m    @browser.div(ELEMENT[item]).span(ELEMENT[:error]).text[m
   end[m
 [m
   def expect_errors(error_messages)[m
