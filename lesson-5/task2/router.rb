module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def enter_id
    print 'Enter post ID: '
    id = nil
    loop do
      id = gets.to_i
      if id.negative? or id >= @posts.length
        print 'Incorrect ID. Try again: '
      else
        break
      end
    end
    id
  end

  def index
    @posts.each.with_index { |post, ind| puts "#{ind} #{post}"}
  end

  def show
    id = enter_id
    puts "#{id} #{@posts[id]}"
  end

  def create
    puts 'Enter your post: '
    post = gets.chomp
    @posts.push(post)
    puts 'Your post has been added!'
    puts "#{@posts.length - 1} #{@posts[-1]}"
  end

  def update
    id = enter_id
    puts 'Enter new post: '
    post = gets.chomp
    @posts[id] = post
    puts 'Your post has been updated!'
    puts "#{id} #{@posts[id]}"
  end

  def destroy
    id = enter_id
    @posts.delete_at(id)
    puts 'Your post has been deleted!'
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init