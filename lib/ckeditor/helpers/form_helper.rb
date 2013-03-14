module Ckeditor
  module Helpers
    module FormHelper
      extend ActiveSupport::Concern

      include ActionView::Helpers::Tags
      include ActionView::Helpers::JavaScriptHelper

      def cktext_area(object_name, method, options = {})
        options = (options || {}).stringify_keys
        ck_options = (options.delete('ckeditor') || {}).stringify_keys

        instance_tag = ActionView::Helpers::Tags::TextArea.new(object_name, method, self, options)
        instance_tag.send(:add_default_name_and_id, options) if options['id'].blank?

        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << instance_tag.render
        output_buffer << javascript_tag(Utils.js_replace(options['id'], ck_options))
        output_buffer
      end
    end
  end
end
