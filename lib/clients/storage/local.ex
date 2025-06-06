defmodule Clients.Storage.Local do
  @moduledoc """
  Storage module to store files locally
  """

  require Logger

  def upload(%{"file" => %Plug.Upload{path: tmp_path, content_type: content_type}}) do
    # Create uploads dir if not exist
    case create_uploads_dir() do
      :ok ->
        # Generate unique filename
        file_name = "#{Ecto.UUID.generate()}.#{ext(content_type)}"
        destination_path = Path.join(uploads_dir(), file_name)

        # Copy file to file system
        case File.cp(tmp_path, destination_path) do
          :ok ->
            Logger.info("File uploaded successfully to #{destination_path}")
            {:ok, Path.join("/uploads", file_name)}

          error ->
            Logger.error("Failed to copy file: #{inspect(error)}")
            {:error, "Failed to save file"}
        end

      {:error, reason} ->
        Logger.error("Failed to create uploads directory: #{inspect(reason)}")
        {:error, "Failed to create uploads directory"}
    end
  end

  def delete_file(file_url) do
    file_path = Path.join(["priv", "static", file_url])

    case File.rm(file_path) do
      :ok ->
        Logger.info("File deleted successfully: #{file_path}")
        :ok

      {:error, reason} ->
        Logger.error("Failed to delete file: #{inspect(reason)}")
        {:error, "Failed to delete file"}
    end
  end

  defp ext(content_type) do
    [ext | _] = MIME.extensions(content_type)
    ext
  end

  defp uploads_dir, do: Path.join(["priv", "static", "uploads"])

  defp create_uploads_dir do
    dir = uploads_dir()

    case File.dir?(dir) do
      true ->
        :ok

      false ->
        case File.mkdir_p(dir) do
          :ok -> :ok
          {:error, reason} -> {:error, reason}
        end
    end
  end
end
