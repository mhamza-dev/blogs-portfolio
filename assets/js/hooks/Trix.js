import Trix from "trix";

export default {
  mounted() {
    const element = document.querySelector("trix-editor");

    element.editor.element.addEventListener("trix-change", (e) => {
      this.el.dispatchEvent(new Event("change", { bubbles: true }));
    });

    // Handles behavior when inserting a file
    element.editor.element.addEventListener(
      "trix-attachment-add",
      function (event) {
        if (event.attachment.file) uploadFileAttachment(event.attachment);
      }
    );

    // Handle behavior when deleting a file
    element.editor.element.addEventListener(
      "trix-attachment-remove",
      function (event) {
        removeFileAttachment(event.attachment.attachment.previewURL);
      }
    );
    function uploadFileAttachment(attachment) {
      uploadFile(attachment.file, setProgress, setAttributes);

      function setProgress(progress) {
        attachment.setUploadProgress(progress);
      }

      function setAttributes(attributes) {
        attachment.setAttributes(attributes);
      }
    }
    function removeFileAttachment(url) {
      const xhr = new XMLHttpRequest();
      const formData = new FormData();
      formData.append("key", url);
      const csrfToken = document
        .querySelector("meta[name='csrf-token']")
        .getAttribute("content");

      xhr.open("DELETE", "/trix-uploads", true);
      xhr.setRequestHeader("X-CSRF-Token", csrfToken);

      xhr.send(formData);
    }

    // Upload file
    function uploadFile(file, progressCallback, successCallback) {
      const formData = createFormData(file);
      const csrfToken = document
        .querySelector("meta[name='csrf-token']")
        .getAttribute("content");
      const xhr = new XMLHttpRequest();

      // Send a POST request to the route previously defined in `router.ex`
      xhr.open("POST", "/trix-uploads", true);
      xhr.setRequestHeader("X-CSRF-Token", csrfToken);

      xhr.upload.addEventListener("progress", function (event) {
        if (event.lengthComputable) {
          const progress = Math.round((event.loaded / event.total) * 100);
          progressCallback(progress);
        }
      });

      xhr.addEventListener("load", function (_event) {
        // The sample code provides a check against a 204 HTTP status
        // However, responseText is empty for this response code, so I switched to a 201 instead.
        // It also makes sense since we are "creating" a new resource inside our content.
        if (xhr.status === 201) {
          // Retrieve the full path of the uploaded file from the server
          const url = xhr.responseText;
          const attributes = {
            url,
            href: `${url}?content-disposition=attachment`,
          };
          successCallback(attributes);
        }
      });

      xhr.send(formData);
    }
  },
};
