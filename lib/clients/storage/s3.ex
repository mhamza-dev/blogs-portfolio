defmodule Clients.Storage.S3 do
  @moduledoc false

  # @s3_region System.get_env("S3_REGION")
  # @s3_access_key_id System.get_env("S3_ACCESS_KEY_ID")
  # @s3_secret_key_access System.get_env("S3_SECRET_KEY_ACCESS")
  # @s3_bucket_name System.get_env("S3_BUCKET_NAME")

  # def upload(%{"Content-Type" => content_type, "file" => %Plug.Upload{path: tmp_path}}) do
  #   file_path = "public/#{Ecto.UUID.generate()}.#{ext(content_type)}"

  #   file = File.read!(tmp_path)
  #   md5 = :md5 |> :crypto.hash(file) |> Base.encode64()

  #   get_client()
  #   |> AWS.S3.put_object(@s3_bucket_name, file_path, %{
  #     "Body" => file,
  #     "ContentMD5" => md5,
  #     "Content-Type" => content_type
  #   })
  #   |> case do
  #     {:ok, _, %{status_code: 200}} ->
  #       {:ok, "#{endpoint()}/#{@s3_bucket_name}/#{file_path}"}

  #     _ = response ->
  #       {:error, "Unable to upload file, please try again later."}
  #   end
  # end

  # def delete_file(file_url) do
  #   key = file_url |> String.split("#{@s3_bucket_name}/") |> List.last()

  #   case AWS.S3.delete_object(get_client(), @s3_bucket_name, key, %{}) do
  #     {:ok, _body, %{status_code: 204}} -> :ok
  #     {:error, _reason} = error -> error
  #   end
  # end

  # defp get_client do
  #   @s3_access_key_id
  #   |> AWS.Client.create(@s3_secret_key_access, @s3_region)
  #   # This line might be irrelevant for you if you are not using backblaze
  #   |> AWS.Client.put_endpoint("s3.#{@s3_region}.backblazeb2.com")
  # end

  # defp endpoint do
  #   "https://s3.#{@s3_region}.backblazeb2.com"
  # end
end
