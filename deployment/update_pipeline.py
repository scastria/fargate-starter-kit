from deployment import create_pipeline


def update():
    create_pipeline.create(True)


if __name__ == '__main__':
    update()
