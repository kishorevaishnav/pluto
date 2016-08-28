defmodule Pluto.UploadController do
  use Pluto.Web, :controller

  alias Pluto.Upload

  def index(conn, _params) do
    uploads = Repo.all(Upload)
    render(conn, "index.json", uploads: uploads)
  end

  def create(conn, %{"upload" => upload_params}) do
    changeset = Upload.changeset(%Upload{}, upload_params)

    case Repo.insert(changeset) do
      {:ok, upload} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", upload_path(conn, :show, :type, :type_id, upload))
        |> render("show.json", upload: upload)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    upload = Repo.get!(Upload, id)
    render(conn, "show.json", upload: upload)
  end

  def update(conn, %{"id" => id, "upload" => upload_params}) do
    upload = Repo.get!(Upload, id)
    changeset = Upload.changeset(upload, upload_params)

    case Repo.update(changeset) do
      {:ok, upload} ->
        render(conn, "show.json", upload: upload)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    upload = Repo.get!(Upload, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(upload)

    send_resp(conn, :no_content, "")
  end
end
