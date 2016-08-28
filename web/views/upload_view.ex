defmodule Pluto.UploadView do
  use Pluto.Web, :view

  def render("index.json", %{uploads: uploads}) do
    %{data: render_many(uploads, Pluto.UploadView, "upload.json")}
  end

  def render("show.json", %{upload: upload}) do
    %{data: render_one(upload, Pluto.UploadView, "upload.json")}
  end

  def render("upload.json", %{upload: upload}) do
    %{id: upload.id,
      s3_url: upload.s3_url,
      type: upload.type,
      type_id: upload.type_id}
  end
end
