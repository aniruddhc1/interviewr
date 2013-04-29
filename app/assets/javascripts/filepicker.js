    filepicker.setKey("AIRdLdHSEQw2Ft9fOjLG7z");

//Notepad
var curr_file;
$(".notepad-open").click(function(){
   filepicker.pick({mimetype:'text/plain', service:'DROPBOX'}, function(fpfile){
      curr_file = fpfile;
      $(".notepad-title").text(fpfile.filename);
      $(".notepad-reload").removeClass("disabled");
      $("#notepad").val("Loading...").attr("disabled", "disabled");
      filepicker.read(curr_file, function(contents){
         firepad.setText(contents);
      });
   });
});
$(".notepad-save").click(function(){
  var btext = $(this).children("span");
  if (curr_file) {
    btext.text("Saving...");
    filepicker.write(curr_file, $firepad.getText(), function(){
        btext.text("Saved");
    });
  } else {
    btext.text("Saving...");
    filepicker.store($("#notepad").val(),
        {filename:'filepicker_note.txt', location: 'S3'},
        function(stored_file){
            filepicker.export(stored_file, {service:'DROPBOX'}, function(fpfile) {
                $(".notepad-title").text(fpfile.filename);
                btext.text("Saved");
                curr_file = fpfile;
            }
        );
    });
  }
});