json.array!(@todos) do |todo|
  json.extract! todo, :id, :item, :completed_at
  json.url list_todo_url(@list, todo, format: :json)
end
